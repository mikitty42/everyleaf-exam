FactoryBot.define do
  factory :task do
    title { 'task1' }
    content { 'content１' }
    limit_date { '2019-11-12'}
    priority {'低'}
    status {'着手中'}
  end
  factory :second_task, class: Task do
    title { 'task2' }
    content { 'content2' }
    limit_date { '2020-11-13'}
    priority {'高'}
    status {'完了'}
  end
end
