class Task < ApplicationRecord
  validates :title,presence: true
  validates :content,presence: true
  validates :limit_date,presence: true
  validates :status,presence: true
  validates :priority,presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :search, -> (task_search_params) do
      return if task_search_params.blank?
      if task_search_params[:title].present? && task_search_params[:status].present?
      title_like(task_search_params[:title])
        .status_is(task_search_params[:status])
      elsif task_search_params[:title].present?
        title_like(task_search_params[:title])
      elsif task_search_params[:status].present?
        status_is(task_search_params[:status])
      end
    end
    scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%")}
    scope :status_is, -> (status) { where(status: status)}
end
