class Task < ApplicationRecord
  validates :title,presence: true
  validates :content,presence: true
  validates :limit_date,presence: true
  enum status:{未着手: 0, 着手: 1, 完了: 2  }
end
