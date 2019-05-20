require 'pry'

class Listing
    attr_reader :city

    @@all = []

    def initialize(city)
        @city = city
        @@all << self
    end

    def guests
        Trip.all.select do |trip_object|
            trip_object.listing == self
        end.map do |selected_trip_object|
            selected_trip_object.guest.name
        end
    end

    def trips
        Trip.all.select do |trip_object|
            trip_object.listing == self
        end.map do |selected_trip_object|
            selected_trip_object
        end
    end

    def trip_count
        count = 0
        Trip.all.each do |trip_object|
            if trip_object.listing == self
                count += 1
            end
        end
        count
    end

    def self.all
        @@all
    end

    def self.find_all_by_city(city)
        Trip.all.select do |trip_object|
            trip_object.listing.city == city
        end.map do |selected_trip_object|
            selected_trip_object.listing
        end
    end

    def self.most_popular
        most_popular = self.all[0]
        self.all.each do |listing_object|
            if listing_object.trip_count > most_popular.trip_count
                most_popular = listing_object
            end
        end
        most_popular
    end
end

class Guest 
    attr_reader :name

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
    end

    def listing 
        Trip.all.select do |trip_object|
            trip_object.guest == self
        end.map do |selected_trip_object|
            selected_trip_object.listing
        end 
    end

    def trips
        Trip.all.select do |trip_object|
            trip_object.guest == self
        end    
    end

    def trip_count 
        count = 0
        Trip.all.each do |trip_object|
            if trip_object.guest == self
                count += 1
            end
        end
        count
    end

    def self.all
        @@all
    end

    def self.pro_traveller
        self.all.select do |guest_object|
            guest_object.trip_count > 1
        end
    end

    def self.find_all_by_name(name)
        self.all.select do |guest_object|
            guest_object.name == name
        end
    end
end

class Trip 

    attr_reader :guest, :listing 

    @@all = []

    def initialize(guest, listing)
        @guest = guest
        @listing = listing
        @@all << self 
    end

    def self.all
        @@all
    end
end

house1 = Listing.new("Houston")
guest1 = Guest.new("Hermann")
trip1 = Trip.new(guest1, house1)

house2 = Listing.new("Houston")
guest2 = Guest.new("Hans")
trip2 = Trip.new(guest2, house2)

house3 = Listing.new("Calgary")
guest3 = Guest.new("Sang")
trip3 = Trip.new(guest3, house3)

puts "starting program"

binding.pry

puts "ending program"