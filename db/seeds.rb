# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Deleting all Reviews, Bookings, Stations, and Users!"
Review.delete_all
Booking.delete_all
Station.delete_all
User.delete_all


# Create 5 Users
puts "Creating Users..."
User.create!(email: 'john2@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
User.create!(email: 'TheHammer@gmail.com', password: 'topsecret', password_confirmation: 'topsecret')
User.create!(email: 'Yourmom@hotmail.com', password: 'topsecret', password_confirmation: 'topsecret')
User.create!(email: 'Fuzz@theWorks.de', password: 'topsecret', password_confirmation: 'topsecret')
User.create!(email: 'NachoLover237@mail.dk', password: 'topsecret', password_confirmation: 'topsecret')
User.create!(email: 'admin@stroom.de', password: 'admin!!', password_confirmation: 'admin!!', admin: true)

# Create 3 Stations
puts "Creating Stations..."
uid_a = User.all.first.id
uid_b = User.all.second.id
uid_c = User.all.third.id

Station.create!(address: "Wendenweg 6, 13595 Berlin, Germany", charger: "bmw", user_id: uid_a)
Station.create!(address: "Klingenhofer Steig 11A, 13587 Berlin, Germany", charger: "tesla", user_id: uid_b)
Station.create!(address: "Innungswall 8, 38518 Gifhorn, Germany", charger: "volvo", user_id: uid_c)


# Create 4 Bookings
puts "Creating Bookings..."
sid_a = Station.all.first.id
sid_b = Station.all.second.id
sid_c = Station.all.third.id

Booking.create!(user_id: uid_a, station_id: sid_a, confirmed: false, start: "2019-02-27 13:22:00", end: "2019-02-27 15:47:00")
Booking.create!(user_id: uid_a, station_id: sid_b, confirmed: true, start: "2019-02-25 16:32:00", end: "2019-02-25 18:22:00")
Booking.create!(user_id: uid_b, station_id: sid_c, confirmed: false, start: "2019-02-22 10:04:00", end: "2019-02-22 11:40:00")
Booking.create!(user_id: uid_c, station_id: sid_c, confirmed: true, start: "2019-03-21 21:22:00", end: "2019-03-22 08:01:00")

# Create a review for each booking
content_array = [
  "Good tasting electricity! Would eat again.",
  "Owner seemed to forget I had booked the spot, but that didn't stop me...",
  "I had the time of my life! 10/10 would charge again!",
  "Turns out you can't charge a gasoline engine with a tesla charger in the tail pipe. My bad."
]

puts "Creating Reviews..."
Booking.all.each do |each|
  Review.create!(accessability: rand(0..5), condition: rand(0..5), overall: rand(0..5), booking_id: each.id, content: content_array[rand(0..3)])
end
