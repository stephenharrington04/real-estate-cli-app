
class User_inputs

  attr_accessor :zip_code, :min_price, :max_price, :bedrooms, :bathrooms, :property_type, :inputs_hash

  def initialize
    @inputs_hash = {}
    @zip_code = self.zip_code?
    @min_price = self.min_price?
    @max_price = self.max_price?
    @bedrooms = self.bedrooms?
    @bathrooms = self.bathrooms?
    @property_type = self.property_type?
  end

  def zip_code?
    zip = ""
    until zip.scan(/\d/).size == 5 && zip.chars.size == 5
      puts "Enter the 5 digit zip code for which you are interested in buying a home."
      zip = gets.strip
      if zip.scan(/\d/).size != 5 || zip.chars.size != 5
        puts ""
        puts "Zip codes must be 5 digits long and must be numbers."
        puts ""
        puts ""
      end
    end
    @inputs_hash["Zip Code"] = zip
    zip
  end

  def min_price?
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
        puts "Please enter a valid min-price from the list below:"
      end
    end
    @inputs_hash["Min Price"] = min_p
    min_p
  end

  def max_price?
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
        puts "Please enter a valid max-price from the list below:"
      end
    end
    @inputs_hash["Max Price"] = max_p
    max_p
  end

  def bedrooms?
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
        puts "Please enter a valid input from the list below:"
      end
    end
    @inputs_hash["Bedrooms"] = beds
    beds
  end

  def bathrooms?
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
        puts "Please enter a valid input from the list below:"
      end
    end
    @inputs_hash["Bathrooms"] = baths
    baths
  end

  def property_type?
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
        puts "Please enter a valid input from the list below:"
      end
    end
    @inputs_hash["Property Type"] = p_type
    p_type
  end

end
