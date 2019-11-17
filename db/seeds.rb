User.create!(name: "Example User",
             email: "example@aaa.com",
             password: "foobar12",
             password_confirmation: "foobar12",
             admin: true)

#30人ユーザーを作成する
30.times do |n|
  name  = Faker::Name.name
  email = "example#{n+1}@aaa.com"
  password = "password12"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

#投稿
# users = User.order(:created_at).take(6)
# 50.times do 
#   description = Faker::Lorem.sentence(5)
#   users.each { |user| user.workouts.create!(description: description) }
# end

#リレーションシップ
users = User.all
user  = users.first
following = users[10..20]
followers = users[21..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
