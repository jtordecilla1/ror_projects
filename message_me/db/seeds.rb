# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(username: "mavis", password: "password")
User.create(username: "john", password: "password")
User.create(username: "jane", password: "password")
User.create(username: "alice", password: "password")
User.create(username: "bob", password: "password")
User.create(username: "charlie", password: "password")

# Messages
Message.create(body: "Hello, world!", user_id: 1)
Message.create(body: "This is a test message.", user_id: 2)
Message.create(body: "How are you doing today?", user_id: 3)
Message.create(body: "Just another message.", user_id: 4)
Message.create(body: "Rails is awesome!", user_id: 1)