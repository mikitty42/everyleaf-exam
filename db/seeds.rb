5.times do |index|
  no = index + 1
  user = User.create(
    name:           "user_#{no}",
    email:  "email_#{no}@example.com",
    password:               "#{no}password#{no}",
  )
  user.save!
end
