User.create!(name: "Example User",
             email: "guest@guest.com",
             password: "guest1234",
             password_confirmation: "guest1234",
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

#リレーションシップ
users = User.all
user  = users.first
following = users[10..20]
followers = users[21..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
