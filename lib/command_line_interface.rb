
class CommandLineInterface
  def run
    welcome_message
    engine
  end

  def welcome_message
    puts "Welcome to the Real Estate Application!"
  end

  def engine
    create_listing(create_search_parameters)
    display_search_results
    next_step(query_mod)
  end

#############Creating Search Parameters##########################################

  def create_search_parameters
    new_search = Search_parameters.new(zip_code, min_price, max_price, bedrooms, bathrooms, property_type).display_search_parameters
    while modify_parameter? == "y"
      type = modify_which_parameter_type?
      new_search.mod_search_parameter(type, modify_parameter_value(type))
      modify_parameter?
    end
    new_search
  end

  def zip_code
    zip = ""
    until zip.scan(/\d/).size == 5 && zip.chars.size == 5
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

  def min_price
    min_p = ""
    valid_prices = ["0", "50000", "100000", "150000", "200000", "250000", "300000", "350000"]
    char_count = valid_prices.join.size
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

  def max_price
    max_p = ""
    valid_prices = ["90000", "180000", "250000", "350000", "450000", "500000", "600000", "any"]
    char_count = valid_prices.join.size
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

  def bedrooms
    beds = ""
    valid_rooms = ["any", "studio", "1+", "2+", "3+", "4+", "5+"]
    char_count = valid_rooms.join.size
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

  def bathrooms
    baths = ""
    valid_baths = ["any", "1+", "2+", "3+", "4+", "5+"]
    char_count = valid_baths.join.size
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

  def property_type
    p_type = ""
    valid_types = ["any", "single family home", "condos/townhomes/co-ops", "mfd/mobile homes", "farms/ranches", "land", "multi-family"]
    char_count = valid_types.join.size
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
      puts "Please enter 'Y' or 'N'."
      input = gets.strip.downcase
    end

  end

  def modify_which_parameter_type?
    valid_parameter_types = ["Zip Code", "Min Price", "Max Price", "Bedrooms", "Bathrooms", "Property Type"]
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
      valid_parameter_types.collect {|type| type.downcase}
        if include?(input)
          mod_type_input = input
        else
          puts "Please enter a valid selection from the list below:".colorize(:red)
        end
    end
    mod_type_input
  end

  def modify_parameter_value(parameter_type)
    case parameter_type
    when "zip code"
      zip_code
    when "min price"
      min_price
    when "max price"
      max_price
    when "bedrooms"
      bedrooms
    when "bathrooms"
      bathrooms
    when "property type"
      property_type
    end
  end

########################################################################


  def next_step(string)
    if string == "1"
      i_listing = more_info
      i_listing_hash = Scraper.listing_scraper(i_listing.house_url)
      expanded_listing = i_listing.add_listing_attributes(i_listing_hash)
      display_individual_listing(expanded_listing)
      next_step(query_mod)
    elsif string == "2"
      Listing.reset_all
      engine
    elsif string == "3"
      puts "Thanks for using the Real Estate Application!"
    end
  end

  def create_listing(search_parameters)
    parsed_criteria = Parser.new(search_parameters)
    url = Url_creator.new(parsed_criteria)
    if Scraper.checker(criteria_url.url) != "404 Error"
      listings_array = Scraper.search_results_scraper(criteria_url.url)
      Listing.create_from_collection(listings_array)
    else
      create_listing(create_search_parameters)
    end
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
