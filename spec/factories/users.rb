FactoryBot.define do
  factory :user do
    nickname              {"miki"}
    email                 {"miki@gmail.com"}
    password              {"12345678"}
    password_confirmation {"12345678"}
  end
end
