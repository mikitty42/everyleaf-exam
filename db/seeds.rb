5.times do |i|
    Label.create!(name: "sample#{i + 1}")
end
10.times do |i|
  Task.create!(
    title: "task#{i + 1}",
    content: "task content#{i + 1}",
    limit_date: DateTime.now + 10,
    status: rand(3),
    priority: rand(3),
    user_id: rand(1..11)
  )
end
User.create!(
    id: 1,
    name: 'admin',
    email: 'admin@testtest.com',
    password: '000000',
    password_confirmation: '000000',
    admin: 'true',
)
10.times do |i|
  User.create!(
    name: "sample#{i}",
    email: "sample#{i}@example.com",
    password: "password#{i}",
    password_confirmation: "password#{i}"
)
