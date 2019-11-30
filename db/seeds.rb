User.create!(name: "管理ユーザー",
             email: "adminuser@aaa.com",
             password: "adminuser12",
             password_confirmation: "adminuser12",
             admin: true)

User.create!(name: "ゲストユーザー",
             email: "guestuser@aaa.com",
             password: "guestuser12",
             password_confirmation: "guestuser12",
             )

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
user  = users.second
following = users[10..20]
followers = users[21..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
