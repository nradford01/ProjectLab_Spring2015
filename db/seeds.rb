User.create!(first_name:  "Example",
             last_name: "User",
             email: "example@projectman.net",
             password:              "password",
             password_confirmation: "password")

9.times do |n|
  first_name  = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "example-#{n+1}@projectman.net"
  password = "password"
  User.create!(first_name:  first_name,
               last_name:   last_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.all

2.times do
  name = Faker::Lorem.sentence(word_count=2)
  description = Faker::Lorem.sentence
  due_date = Faker::Date.forward(1)
  users.each do |user| 
    project = user.projects.create!(name: name, description: description, due_date: due_date)
    project.tasks.create!(name: name, description: description, due_date: due_date, user_id: user.id, assigned_user_id: rand(9))
  end
end



# Project.all.each do |p|
#   5.times do 
#    name = Faker::Lorem.sentence(word_count=2)
#   description = Faker::Lorem.sentence
#   due_date = Faker::Date.forward(1)
#   p.tasks.create!(name: name, description: description, due_date: due_date, user_id: rand(9), assigned_user_id: rand(9))
#  end
# end

# projects = Project.all
# tasks = Task.all

# 2.times do
#   name = Faker::Lorem.sentence(word_count=2)
#   description = Faker::Lorem.sentence
#   due_date = Faker::Date.forward(1)
#   user = User.all
#   assigned_user = User.all
#   users.each { |user| user.projects.tasks.create!(name: name, description: description, due_date: due_date, assigned_user: assigned_user)}
# end