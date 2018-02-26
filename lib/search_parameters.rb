class Search_parameters

  attr_accessor :zip_code, :min_price, :max_price, :bedrooms, :bathrooms, :property_type

  def initialize(zip_code, min_price, max_price, bedrooms, bathrooms, property_type)
    @zip_code = zip_code
    @min_price = min_price
    @max_price = max_price
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @property_type = property_type
  end

  def display_search_parameters
    puts ""
    puts "These are the search parameters you've entered:"
    puts "Zip Code:  #{self.zip_code}"
    puts "Minimum Price:  #{self.min_price}"
    puts "Maximum Price:  #{self.max_price}"
    puts "# of Bedrooms:  #{self.bedrooms}"
    puts "# of Bathrooms:  #{self.bathrooms}"
    puts "Property Type:  #{self.property_type}"
    puts ""
  end

  def mod_search_parameter(parameter_type, parameter_mod)
    case parameter_type
      when "zip code"
        self.zip_code = parameter_mod
      when "min price"
        self.min_price = parameter_mod
      when "max price"
        self.max_price = parameter_mod
      when "bedrooms"
        self.bedrooms = parameter_mod
      when "bathrooms"
        self.bathrooms = parameter_mod
      when "property type"
        self.property_type = parameter_mod
    end
  end

end
