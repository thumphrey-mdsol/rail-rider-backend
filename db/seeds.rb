# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying users"
User.destroy_all
puts "destroying station"
Stop.destroy_all
puts "destroying Subway"
Trainline.destroy_all
puts "destroying Favorites"
Favorite.destroy_all
puts "destroying Update"
Arrival.destroy_all

puts "creating User"
User.create(username: 'tom', password: 'tom', email: 'tom@tom.com')

puts "creating stations"
puts "creating train lines"
destination_array = ["Uptown", "Downtown"]
subway_info = JSON.parse(RestClient.get('https://data.cityofnewyork.us/resource/kk4q-3rt2.json'))
subway_info.sort_by{|line| line["name"]}
subway_info.each do |object|
    stop = Stop.find_or_create_by(stop_name: object["name"])
    stop.update(stop_lat: object["the_geom"]["coordinates"][1], stop_lon: object["the_geom"]["coordinates"][0])
    if object["line"].split("").length > 0
        obj = object["line"].scan(/\w+/)
        obj.each do |line|
            train = Trainline.find_or_create_by(name: line)
            train.update(destination: destination_array.sample)
            Arrival.create(stop_id: stop.id,trainline_id: train.id)
        end
    end
end

response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
puts "Got response"
response_string.gsub!("NQR","NQRW")
response = JSON.parse(Hash.from_xml(response_string).to_json)
puts "Made it JSON"
response["service"]["subway"]["line"][0..-2].each do |line|
    puts "About to make lines"
    if line["text"] == nil
        puts"Making good service line"
        line["name"].split("").each{|indiv| 
            train = Trainline.where(name: indiv)
            train.update(name: indiv, status: line["status"])
        }
    else
        puts "Making delayed line"
        line["text"] = line["text"].gsub("<br clear=left>"," ")
        elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
        line["name"].split("").each{|indiv| 
            train = Trainline.where(name: indiv)
            train.update(name: indiv, status: line["status"], status_description: elaboration)
        }
    end
end
    
def arrival_time
    a = rand(0..1).to_s
    b = rand(0..9).to_s
    c = ":"
    d = rand(0..5).to_s
    e = rand(0..9).to_s
    a+b+c+d+e
end

puts "seeding arrivals"
100.times do
    # Arrivaltime.create(stop_id:  rand(Stop.first.id..Stop.last.id), trainline_id: rand(Trainline.first.id..Trainline.last.id))
    Arrivaltime.create(arrival_id: rand(Arrival.first.id..Arrival.last.id), arrival_time: arrival_time)
end

puts "creating Favorites"
Favorite.create(user_id: User.first.id, stop_id: rand(Stop.first.id..Stop.last.id), name: "Home")
Favorite.create(user_id: User.first.id, stop_id: rand(Stop.first.id..Stop.last.id), name: "Work")