FactoryBot.define do
  factory :task do
    #id { 1 }
    title { 'task1' }
    content { 'content１' }
    limit_date { '2020-04-01'}
    priority { '高' }
    status {'完了'}
    user
  end
  factory :second_task, class: Task do
    #id { 2 }
    title { 'task2' }
    content { 'content2' }
    limit_date { '2020-04-02'}
    priority { '中' }
    status {'完了'}
    user
  end
  factory :third_task, class: Task do
    #id { 3 }
    title { 'task3' }
    content { 'content3' }
    limit_date { '2020-04-03' }
    priority { '低' }
    status { '完了' }
    user
  end
end
