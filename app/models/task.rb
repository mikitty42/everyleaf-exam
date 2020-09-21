class Task < ApplicationRecord
  validates :title,presence: true
  validates :content,presence: true
  validates :limit_date,presence: true
end
