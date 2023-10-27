# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Creating a new order
#Dorder = Order.create(status: 'Pending', user_id: user.id, cafe_id: cafe.id)

# In the Rails console
#User.create!(email: 'user3@example.com', password: 'password', password_confirmation: 'password', role: 'Admin')
#User.create!(email: 'user4@example.com', password: 'password', password_confirmation: 'password', role: 'Cafeowner')
#User.create!(email: 'user7@example.com', password: 'password', password_confirmation: 'password', role: 'Customer')


# Admin.create(email: 'admin15433@example.com', password:'shruti@123',password_confirmation: 'shruti@123')
roles = ["admin","cafeowner", "customer"]
roles.each do |role|
  Role.find_or_create_by(name: role)
end

User.create(email: "testcode3210@gmail.com",password: "password@123",password_confirmation: "password@123",f_name: "shruti", l_name: "purohit", role_id:Role.first.id)

#User.create(email: "mishradhruv98@gmail",password: "password",password_confirmation: "password",f_name: "test", l_name: "code", role_id:Role.second.id)