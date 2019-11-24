FactoryBot.define do
  factory :user do
    name     { 'テストユーザー' }
    email    { 'example@example.com' }
    password { 'password12' }
  end
end