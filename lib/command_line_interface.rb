class CommandLineInterface

  def run
    welcome_message
    create_listings(create_search_parameters)
    display_search_results
    no_results?
    what_next?
  end

  def welcome_message
    puts ""
    puts "--------------------------------------------".colorize(:blue)
    puts "|  WELCOME TO THE REAL ESTATE APPLICATION  |".colorize(:blue)
    puts "--------------------------------------------".colorize(:blue)
  end

  def start_over
    Listing.reset_all
    run
  end

  def no_results?
    start_over if Listing.all == []
  end

  def what_next?
    selection = options_after_listings_results
    if selection == "1"
      individual_listing
      what_next?
    elsif selection == "2"
      start_over
    else
      puts ""
      puts "Thanks for using the Real Estate Application!"
      puts ""
    end
  end

  def options_after_listings_results
    option = ""
    puts ""
    puts "Would you like to:"
    puts "(1) Get more information about a listing"
    puts "(2) Start a new search"
    puts "(3) Exit"
    until option != ""
      puts "Select '1' '2' or '3'"
      input = gets.strip
      if input == "1" || input == "2" || input == "3"
        option = input
      end
    end
    option
  end

####################################Creating Search Parameters####################################

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

  ####################################Creating Listings####################################

  def create_listings(search_parameters)
    website = Url_creator.url_maker(Formatter.format_parameters(search_parameters))
    if Scraper.checker(website) != "404 Error"
      Listing.create_from_collection(Scraper.search_results_scraper(website))
    else
      create_listings(search_parameters)
    end
  end

  def individual_listing
    individual_listing = select_listing
    individual_listing_hash = Scraper.listing_scraper(individual_listing.house_url)
    expanded_listing = individual_listing.add_listing_attributes(individual_listing_hash)
    display_individual_listing(expanded_listing)
  end

  def select_listing
    listing_index = ""
    available_numbers = Listing.all.size
    puts "You only have one available listing" if available_numbers == 1
    puts ""
    puts "For which listing do you want more information?"
    until listing_index != ""
      puts "Please select 1 - #{available_numbers.to_s}"
      which_listing = gets.strip
      if which_listing.to_i > 0 && which_listing.to_i <= available_numbers
        listing_index = which_listing
      end
    end
    Listing.all[(listing_index.to_i) - 1]
  end

  def display_search_results
    counter = 1
    if Listing.all == []
      puts ""
      puts ""
      puts "No results found.  Please enter new search criteria.".colorize(:red)
      puts ""
    else
      puts ""
      puts "    -----------------------------".colorize(:green)
      puts "    | DISPLAYING SEARCH RESULTS |".colorize(:green)
      puts "    -----------------------------".colorize(:green)
      Listing.all.each do |listing|
        puts ""
        puts "(#{counter})".colorize(:light_blue)
        puts "   Address:".colorize(:light_blue) + "  #{listing.address ||= "Information not provided"}"
        puts "   Price:".colorize(:light_blue) + "  #{listing.price ||= "Information not provided"}"
        puts "   # Of Bedrooms:".colorize(:light_blue) + "  #{listing.beds ||= "Information not provided"}"
        puts "   # Of Bathrooms:".colorize(:light_blue) + "  #{listing.baths ||= "Information not provided"}"
        puts "   Sqft:".colorize(:light_blue) + "  #{listing.sqft ||= "Information not provided"}"
        puts "   Listing URL:".colorize(:light_blue) + "  #{listing.house_url ||= "Information not provide"}"
        counter += 1
      end
    end
  end

  def display_individual_listing(listing)
    puts "Address:".colorize(:light_blue) + "  #{listing.address ||= "Information not provided"}"
    puts "Price:".colorize(:light_blue) + "  #{listing.price ||= "Information not provided"}"
    puts "Status:".colorize(:light_blue) + "  #{listing.status ||= "Information not provided"}"
    puts "Year Built:".colorize(:light_blue) + "  #{listing.year_built ||= "Information not provided"}"
    puts "Days on Market:".colorize(:light_blue) + "  #{listing.days_on_market ||= "Information not provided"}"
    puts "# Of Bedrooms:".colorize(:light_blue) + "  #{listing.beds ||= "Information not provided"}"
    puts "# of Bathrooms:".colorize(:light_blue) + "  #{listing.baths ||= "Information not provided"}"
    puts "Square Feet (livable):".colorize(:light_blue) + "  #{listing.sqft ||= "Information not provided"}"
    puts "Acres / Sqft (property):".colorize(:light_blue) + "  #{listing.acres ||= "Information not provided"}"
    puts "Price per SqFt:".colorize(:light_blue) + "  #{listing.price_per_sqft ||= "Information not provided"}"
    puts "Property Type:".colorize(:light_blue) + "  #{listing.property_type ||= "Information not provided"}"
    puts "Listing URL:".colorize(:light_blue) + "  #{listing.house_url ||= "Information not provided"}"
    puts "Description:".colorize(:light_blue) + "  #{listing.description ||= "Information not provided"}"
  end

end
