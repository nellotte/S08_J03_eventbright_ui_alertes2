# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

# Création de 10 utilisateurs
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name.downcase}.#{last_name.downcase}@yopmail.com"
  description = Faker::Quote.yoda
 

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    description: description,
    password: "password"
  )
end

puts "Les users ont été créés"

# Création de 5 events
10.times do
  Event.create(
    start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 60), 
    duration: [15, 30, 60, 90, 120].sample, 
    title: Faker::Movie.title, # Utilise le titre d'un film aléatoire
    description: Faker::Movie.quote, # Utilise le résumé d'un film aléatoire
    price: Faker::Number.within(range: 1..100),
    location: Faker::Address.city)
end

puts "Les events ont été créés"

# Création de 15 attendances
50.times do 
  Attendance.create(
    stripe_customer_id: "stringtest",
    user_id: User.all.sample.id, 
    event_id: Event.all.sample.id)
end

puts "Les attendances ont été créés"