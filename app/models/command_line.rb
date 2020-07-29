require_relative "location.rb"
require_relative "movie.rb"
require_relative "movie_location.rb"
require_relative "review.rb"
require_relative "user.rb"

class CommandLine

    def initialize
        self.logo
        self.welcome_message
        self.login_or_create_prompt
    end

    def logo
        puts "
        _______.  ______  _______ .__   __.  _______     __  .___________. __  
        /       | /      ||   ____||  \ |  | |   ____|   |  | |           ||  | 
       |   (----`|  ,----'|  |__   |   \|  | |  |__      |  | `---|  |----`|  | 
        \   \    |  |     |   __|  |  . `  | |   __|     |  |     |  |     |  | 
    .----)   |   |  `----.|  |____ |  |\   | |  |____    |  |     |  |     |__| 
    |_______/     \______||_______||__| \__| |_______|   |__|     |__|     (__) 
    
        "
    end

    def welcome_message
        puts "Welcome to Scene It!"
        puts "\n"
        puts "This is an app designed to find movie and TV show film locations from all around the world!"
        puts "\n"
    end

    def login_or_create_prompt
        puts "Choose one of the options below:"
        puts "1. Create an account"
        puts "2. Log in with username"
    end

    def success_login_message
        puts "You've successfully logged into your account!"
    end

    def success_created_account_message
        puts "You've successfully created an account!"
    end

    def present_menu
        puts "Please choose one of the menu options below:"
        puts "\n"
        puts "Menu:"
        puts "\n"
        puts "1. Search for film locations by movie or TV show"
        puts "2. Search for movies or TV shows filmed in a certain city"
        puts "3. Add a movie or TV show to the database"
        puts "4. Add a location to a movie or TV show"
        puts "5. Review a film location"
        puts "6. Show all my reviews"
        puts "7. Look up all the reviews by film location"
        puts "8. Find the highest-rated film location"
        puts "9. Find the top-5 film locations"
        puts "10. Look up the most-visited film location"
    end

    def search_for_locations_by_movie
        puts "Enter a movie or TV show"
        user_input = gets.chomp
        # puts "#{user_input}"
        puts "\n"
        movie_object = Movie.find_movie(user_input)
        movie_object.locations.map do |location|
            location.formatted_print
        end
    end
    
    def search_for_movie_by_city
        puts "Enter city name"
        user_input_city = gets.chomp
        puts "\n"
        puts "Enter country name"
        user_input_country = gets.chomp
        puts "\n"
        location_object = Location.find_location_by_city(user_input_city, user_input_country)
        location_object.movies.map do |movies|
            movies.formatted_print
        end
    end

    def search_for_movie_by_landmark
        puts "Enter landmark name"
        user_input_landmark = gets.chomp
        puts "\n"
        location_object = Location.find_location_by_name(user_input_landmark)
        location_object.movies.map do |movies|
            movies.formatted_print
        end
    end

    def add_movie_to_database
        puts "which movie or TV show you would like to add?"
        user_input_movie_or_TVshow = gets.chomp
        puts "\n"
        puts "Is this a movie or a TV show?"
        user_input_type = gets.chomp
        puts "\n"
       data = Movie.check_if_movie_in_database(user_input_movie_or_TVshow, user_input_type)
        if data == true 
            puts " This movie alreadys exists in the database"
        else 
            capitalized_movie_name = user_input_movie_or_TVshow.titleize
            Movie.create(name: capitalized_movie_name,movie_or_tvshow: user_input_type)
            puts "#{capitalized_movie_name} was successfully added to the database"

        end
    end
end