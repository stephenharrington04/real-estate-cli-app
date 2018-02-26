require 'pry'
class CommandLineInterface
  def run
    welcome_message
    engine
  end

  def welcome_message
    puts "Welcome to the Real Estate Application!"
  end

  def engine
    new_search = create_search_parameters
    create_listings(new_search)
    Listing.display_search_results
    case query_mod
    when "1"
      individual_listing
      query_mod
    when "2"
      start_over
    when "3"
      puts "Thanks for using the Real Estate Application!"
    end
  end

#############Creating Search Parameters##########################################

  def create_search_parameters
    new_search = Search_parameters.new(set_zip_code, set_min_price, set_max_price, set_bedrooms, set_bathrooms, set_property_type)
    new_search.display_search_parameters
    while modify_parameter? == "y"
      type = modify_which_parameter_type?
      mod = modify_parameter_value(type)
      new_search.mod_search_parameter(type, mod)
      new_search.display_search_parameters
    end
    new_search
  end

  def set_zip_code
    zip = ""
    until zip.scan(/\d/).size == 5 && zip.chars.size == 5
      puts ""
      puts "Enter the 5 digit zip code for which you are interested in buying a home."
      zip = gets.strip
      if zip.scan(/\d/).size != 5 || zip.chars.size != 5
        puts ""
        puts "Zip codes must be 5 digits long and must be numbers.".colorize(:red)
        puts ""
        puts ""
      end
    end
    zip
  end

  def set_min_price
    min_p = ""
    valid_prices = ["0", "50000", "100000", "150000", "200000", "250000", "300000", "350000"]
    char_count = valid_prices.join.size
    puts ""
    puts "Enter a min-price for the home in which you wish to purchase:"
    until min_p != ""
      (char_count + (5 * (valid_prices.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_prices.each {|price| print "     #{price}"}
      puts ""
      (char_count + (5 * (valid_prices.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.gsub(",","")
      if valid_prices.include?(input)
        min_p = input
      else
        puts ""
        puts ""
        puts "Please enter a valid min-price from the list below:".colorize(:red)
      end
    end
    min_p
  end

  def set_max_price
    max_p = ""
    valid_prices = ["90000", "180000", "250000", "350000", "450000", "500000", "600000", "any"]
    char_count = valid_prices.join.size
    puts ""
    puts "Enter a max-price for the home in which you wish to purchase:"
    until max_p != ""
      (char_count + (5 * (valid_prices.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_prices.each {|price| print "     #{price}"}
      puts ""
      (char_count + (5 * (valid_prices.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.downcase.gsub(",","")
      if valid_prices.include?(input)
        max_p = input
      else
        puts ""
        puts ""
        puts "Please enter a valid max-price from the list below:".colorize(:red)
      end
    end
    max_p
  end

  def set_bedrooms
    beds = ""
    valid_rooms = ["any", "studio", "1+", "2+", "3+", "4+", "5+"]
    char_count = valid_rooms.join.size
    puts ""
    puts "Enter the number of bedrooms for the home in which you wish to purchase:"
    until beds != ""
      (char_count + (5 * (valid_rooms.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_rooms.each {|room| print "     #{room}"}
      puts ""
      (char_count + (5 * (valid_rooms.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.downcase
      if valid_rooms.include?(input)
        beds = input
      else
        puts ""
        puts ""
        puts "Please enter a valid input from the list below:".colorize(:red)
      end
    end
    beds
  end

  def set_bathrooms
    baths = ""
    valid_baths = ["any", "1+", "2+", "3+", "4+", "5+"]
    char_count = valid_baths.join.size
    puts ""
    puts "Enter the number of bathrooms for the home in which you wish to purchase:"
    until baths != ""
      (char_count + (5 * (valid_baths.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_baths.each {|room| print "     #{room}"}
      puts ""
      (char_count + (5 * (valid_baths.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.downcase
      if valid_baths.include?(input)
        baths = input
      else
        puts ""
        puts ""
        puts "Please enter a valid input from the list below:".colorize(:red)
      end
    end
    baths
  end

  def set_property_type
    p_type = ""
    valid_types = ["any", "single family home", "condos/townhomes/co-ops", "mfd/mobile homes", "farms/ranches", "land", "multi-family"]
    char_count = valid_types.join.size
    puts ""
    puts "Enter the type of property you wish to purchase:"
    until p_type != ""
      (char_count + (5 * (valid_types.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_types.each {|type| print "     #{type}"}
      puts ""
      (char_count + (5 * (valid_types.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.downcase
      if valid_types.include?(input)
        p_type = input
      else
        puts ""
        puts ""
        puts "Please enter a valid input from the list below:".colorize(:red)
      end
    end
    p_type
  end

  def modify_parameter?
    input = ""
    until input == "y" || input == "n"
      puts "Would you like to modify one of your search parameters?"
      puts "Please enter 'Y' or 'N'"
      input = gets.strip.downcase
    end
    input
  end

  def modify_which_parameter_type?
    valid_parameter_types = ["Zip Code", "Min Price", "Max Price", "Bedrooms", "Bathrooms", "Property Type"]
    valid_types_guard = valid_parameter_types.collect {|type| type.downcase}
    char_count = valid_parameter_types.join.size
    mod_type_input = ""
    puts "Which search parameter would you like to modify?"
    until mod_type_input != ""
      (char_count + (5 * (valid_parameter_types.size + 1))).times {print "-".colorize(:green)}
      puts ""
      valid_parameter_types.each {|type| print "     #{type}"}
      puts ""
      (char_count + (5 * (valid_parameter_types.size + 1))).times {print "-".colorize(:green)}
      puts ""
      input = gets.strip.downcase
      if valid_types_guard.include?(input)
        mod_type_input = input
      else
        puts ""
        puts "Please enter a valid selection from the list below:".colorize(:red)
        puts ""
      end
    end
    mod_type_input
  end

  def modify_parameter_value(parameter_type)
    case parameter_type
    when "zip code"
      set_zip_code
    when "min price"
      set_min_price
    when "max price"
      set_max_price
    when "bedrooms"
      set_bedrooms
    when "bathrooms"
      set_bathrooms
    when "property type"
      set_property_type
    end
  end

########################################################################


  def individual_listing
    individual_listing = more_info
    individual_listing_hash = Scraper.listing_scraper(individual_listing.house_url)
    expanded_listing = individual_listing.add_listing_attributes(individual_listing_hash)
    Listing.display_individual_listing(expanded_listing)
  end

  def create_listings(search_parameters)
    formatted_search_parameters = Formatter.format_parameters(search_parameters)
    website = Url_creator.new(formatted_search_parameters)
    if Scraper.checker(website.url) != "404 Error"
      listings_array = Scraper.search_results_scraper(website.url)
      Listing.create_from_collection(listings_array)
    else
      create_listings(search_parameters)
    end
  end

  def start_over
    Listing.reset_all
    engine
  end

  def query_mod
    query = ""
    puts ""
    puts "Would you like to:"
    puts "(1) Get more information about a listing"
    puts "(2) Start a new search"
    puts "(3) Exit"
    until query != ""
      puts "Select '1' '2' or '3'"
      input = gets.strip
      if input == "1" || input == "2" || input == "3"
        query = input
      end
    end
    query
  end

  def more_info
    more = ""
    available_numbers = Listing.all.size
    puts "You only have one available listing" if available_numbers == 1
    puts ""
    puts "For which listing do you want more information?"
    until more != ""
      puts "Please select 1 - #{available_numbers.to_s}"
      which_listing = gets.strip
      if which_listing.to_i > 0 && which_listing.to_i <= available_numbers
        more = which_listing
      end
    end
    Listing.all[(more.to_i) - 1]
  end

end
