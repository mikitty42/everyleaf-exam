class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                    before_validation { email.downcase! }
  has_many :tasks,dependent: :destroy
  has_secure_password
  validates :password, presence: true, on: :create
  validates :password, length: { maximum: 30 }, allow_blank: true, on: :update
  before_destroy :destroy_action
  before_update :update_action

  private

  def destroy_action
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort)
    end
  end

  def update_action
    user = User.where(id: self.id).where(admin: true)
    if User.where(admin: true).count == 1 && user.present? && self.admin == false
      errors.add(:admin, 'から外せません。最低一人の管理者が必要です')
      throw(:abort)
    end
  end
end
