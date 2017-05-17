class User_inputs

  def zip_code
    zip = ""
    until zip.chars.size == 5
      puts "Enter the 5 digit zip code for which you are interested in buying a home."
      zip = gets.strip
      if zip.chars.size != 5
        puts ""
        puts "Zip codes must be 5 digits long."
        puts ""
        puts ""
      end
    end
    zip
  end

  def min_price
    min_p = ""
    valid_prices = ["0", "50000", "100000", "150000", "200000", "250000", "300000", "350000"]
    until min_p != ""
      puts "Enter a min-price for the home in which you wish to purchase:"
      valid_prices.each {|price| puts "#{price}"}
      input = gets.strip
      if valid_prices.include?(input)
        min_p = input
      else
        puts ""
        puts "Please enter a valid min-price."
        puts ""
        puts ""
      end
    end
    min_p
  end

  def max_price
    max_p = ""
    valid_prices = ["90000", "180000", "250000", "350000", "450000", "500000", "600000", "any price"]
    until max_p != ""
      puts "Enter a max-price for the home in which you wish to purchase:"
      valid_prices.each {|price| puts "#{price}"}
      input = gets.strip
      if valid_prices.include?(input)
        max_p = input
      else
        puts ""
        puts "Please enter a valid max-price."
        puts ""
        puts ""
      end
    end
    max_p
  end

  def bedrooms
    beds = ""
    valid_rooms = ["any", "studio", "1+", "2+", "3+", "4+", "5+"]
    until beds != ""
      puts "Enter the number of bedrooms for the home in which you wish to purchase:"
      valid_rooms.each {|room| puts "#{room}"}
      input = gets.strip
      if valid_rooms.include?(input)
        beds = input
      else
        puts ""
        puts "Please enter a valid input."
        puts ""
        puts ""
      end
    end
    beds
  end

  def bathrooms
    baths = ""
    valid_baths = ["any", "1+", "2+", "3+", "4+", "5+"]
    until baths != ""
      puts "Enter the number of bathrooms for the home in which you wish to purchase:"
      valid_baths.each {|room| puts "#{room}"}
      input = gets.strip
      if valid_baths.include?(input)
        baths = input
      else
        puts ""
        puts "Please enter a valid input."
        puts ""
        puts ""
      end
    end
    baths
  end

end
