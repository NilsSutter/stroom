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
User.create!(email: 'john2@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', first_name: "John", last_name: "McCormick")
User.create!(email: 'TheHammer@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', first_name: "David", last_name: "Jhonson")
User.create!(email: 'Yourmom@hotmail.com', password: 'topsecret', password_confirmation: 'topsecret', first_name: "Christian", last_name: "Jeffries")
User.create!(email: 'Fuzz@theWorks.de', password: 'topsecret', password_confirmation: 'topsecret', first_name: "Jeff", last_name: "Plaut")
User.create!(email: 'NachoLover237@mail.dk', password: 'topsecret', password_confirmation: 'topsecret', first_name: "Nicolas", last_name: "Hammer")
User.create!(email: 'admin@cn.com', password: 'admin!!', password_confirmation: 'admin!!', admin: true, first_name: "Admin", last_name: "Admin")

# Create 3 Stations
puts "Creating Stations..."
uid_a = User.all.first.id
uid_b = User.all.second.id
uid_c = User.all.third.id
uid_d = User.all.fourth.id

puts "Creating instructions"
instruction_array = [
"The garage is located at a beautiful spot near our lovely house. You can access the car plug easily. In case you have any questions
you can contact us anytime. We would love to hear from you.",
"Well, basically this is a parking spot with a car plug. It is pretty straight forward & self-explaining. Nothing special about it.
Go ahead and charge your car.",
"We are offering this unique charging spot. It is a really, really great charging spot. Also I am a placeholder sample text.",
"This garage is the best garage we have the offer. It is truely magnificent. Rich stayed here once and loved it. Feel free to come. Bring your friends.",
"While charging your car, feel free to enjoy a beer at our pub nearby. We will be very happy to welcome you!"
]
puts "fetching sample images"
url_a = "https://images.unsplash.com/photo-1523828342112-3deb811c3451?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=80"
url_b = "https://images.unsplash.com/photo-1472377521129-f4ddafa8b372?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
url_c = "https://images.unsplash.com/photo-1439158741799-12ded9a3ba30?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1721&q=80"
url_d = "https://images.unsplash.com/photo-1517490232338-06b912a786b5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80"
url_e = "https://images.unsplash.com/photo-1505545121909-2d48e22dede6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_f = "https://images.unsplash.com/photo-1489847737011-2f9e5f5aa2e1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_g = "https://images.unsplash.com/photo-1547138666-943b08b83c0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_h = "https://images.unsplash.com/photo-1494351416886-f6b4ed2a1d68?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_i = "https://images.unsplash.com/photo-1445548671936-e1ff8a6a6b20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"

station_a = Station.new(address: "Wendenweg 6, 13595 Berlin, Germany", charger: "bmw", user_id: uid_a, price: 0.4, instruction: instruction_array[rand(0..4)])
station_b = Station.new(address: "Klingenhofer Steig 11A, 13587 Berlin, Germany", charger: "tesla", user_id: uid_b, price: 0.5, instruction: instruction_array[rand(0..4)])
station_c = Station.new(address: "Innungswall 8, 38518 Gifhorn, Germany", charger: "volvo", user_id: uid_c, price: 1.2, instruction: instruction_array[rand(0..4)])
station_d = Station.new(address: "Graefestraße 76, 10967 Berlin, Germany", charger: "mercedes", user_id: uid_a, price: 1.1, instruction: instruction_array[rand(0..4)])
station_e = Station.new(address: "Brennerstraße 12, 13187 Berlin, Germany", charger: "mercedes", user_id: uid_a, price: 0.9, instruction: instruction_array[rand(0..4)])
station_f = Station.new(address: "Kurfürstenstraße 187, 10785 Berlin, Germany", charger: "bmw", user_id: uid_d, price: 1.4, instruction: instruction_array[rand(0..4)])
station_g = Station.new(address: "Rudi-Arndt-Straße 43, 10407 Berlin, Germany", charger: "mercedes", user_id: uid_a, price: 0.6, instruction: instruction_array[rand(0..4)])
station_h = Station.new(address: "Horst-Kohl-Straße 4, 12157 Berlin, Germany", charger: "bmw", user_id: uid_c, price: 0.8, instruction: instruction_array[rand(0..4)])
station_i = Station.new(address: "Unter den Linden 5, 10117 Berlin, Germany", charger: "bmw", user_id: uid_d, price: 0.5, instruction: instruction_array[rand(0..4)])

station_a.remote_photo_url = url_a
station_b.remote_photo_url = url_b
station_c.remote_photo_url = url_c
station_d.remote_photo_url = url_d
station_e.remote_photo_url = url_e
station_f.remote_photo_url = url_f
station_g.remote_photo_url = url_g
station_h.remote_photo_url = url_h
station_i.remote_photo_url = url_i

station_a.save!
station_b.save!
station_c.save!
station_d.save!
station_e.save!
station_f.save!
station_g.save!
station_h.save!
station_i.save!


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
  xxx = Review.new(accessability: rand(0..5), condition: rand(0..5), overall: rand(0..5), booking_id: each.id, content: content_array[rand(0..3)])
  xxx.station = station_a
  xxx.save
end
