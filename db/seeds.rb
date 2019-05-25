# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

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

# Create 60 Stations
puts "Creating Stations..."

Station.create()

instruction_array = [
"The garage is located at a beautiful spot near our lovely house. You can access the car plug easily. In case you have any questions
you can contact us anytime. We would love to hear from you.",
"Well, basically this is a parking spot with a car plug. It is pretty straight forward & self-explaining. Nothing special about it.
Go ahead and charge your car.",
"We are offering this unique charging spot. It is a really, really great charging spot. Also I am a placeholder sample text.",
"This garage is the best garage we have the offer. It is truely magnificent. Rich stayed here once and loved it. Feel free to come. Bring your friends.",
"While charging your car, feel free to enjoy a beer at our pub nearby. We will be very happy to welcome you!"
]

url_a = "https://images.unsplash.com/photo-1523828342112-3deb811c3451?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=80"
url_b = "https://images.unsplash.com/photo-1472377521129-f4ddafa8b372?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
url_c = "https://images.unsplash.com/photo-1439158741799-12ded9a3ba30?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1721&q=80"
url_d = "https://images.unsplash.com/photo-1517490232338-06b912a786b5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80"
url_e = "https://images.unsplash.com/photo-1505545121909-2d48e22dede6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_f = "https://images.unsplash.com/photo-1489847737011-2f9e5f5aa2e1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_g = "https://images.unsplash.com/photo-1547138666-943b08b83c0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_h = "https://images.unsplash.com/photo-1494351416886-f6b4ed2a1d68?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
url_i = "https://images.unsplash.com/photo-1445548671936-e1ff8a6a6b20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"

chargers = ["tesla", "mercedes", "bmw", "volkswagen", "volvo", "ford"]
place_types = ["gym", "cafe", "church"]

place_types.each do |type|
  gm_return = JSON.parse(open("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV['GOOGLE_MAPS_KEY']}&location=52.52,13.4050&radius=10000&type=#{type}").read)

  gm_return["results"].each do |location|
    puts "> Creating Station at #{location['vicinity']}"
    s = Station.new(address: location["vicinity"], charger: chargers[rand(0..5)], user_id: User.all[rand(0..(User.all.count - 1))].id, price: (rand(1..9)/10.to_f), instruction: instruction_array[rand(0..4)])

    image_check_metadata = JSON.parse(open("https://maps.googleapis.com/maps/api/streetview/metadata?location=#{location['geometry']['location']['lat']},#{location['geometry']['location']['lng']}&key=#{ENV['GOOGLE_MAPS_KEY']}").read)

    if image_check_metadata["status"] == "ZERO_RESULTS"
      s.remote_photo_url = "https://images.unsplash.com/photo-1523828342112-3deb811c3451?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=80"
    else
      s.remote_photo_url = "https://maps.googleapis.com/maps/api/streetview?location=#{location['geometry']['location']['lat']},#{location['geometry']['location']['lng']}&key=#{ENV['GOOGLE_MAPS_KEY']}&size=1024x1024"
    end

    s.save!

    time = Time.now + (86400 * (s.id + 1))
    1.times do
      puts "Creating Booking...#{s.id}"
      Booking.create!(user_id: User.all.first.id, station_id: s.id, confirmed: false, start: time, end: time + (s.id * 10))
      Booking.create!(user_id: User.all.second.id, station_id: s.id, confirmed: false, start: time + 10000, end: time + 10000 + (s.id * 10))
      Booking.create!(user_id: User.all.third.id, station_id: s.id, confirmed: false, start: time + 30000, end: time + 30000 + (s.id * 10))
    end
  end
end
#



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
  xxx.station = Station.all[rand(0..(Station.all.count - 1))]
  xxx.save!
end
#
# puts "Deleting Problem Child"
# Station.where(address: "Bezirk Mitte").first.destroy
