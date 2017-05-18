class Parser

  attr_reader :parsed_zip_code, :parsed_price, :parsed_bedrooms, :parsed_bathrooms, :parsed_property_type

  def initialize(inputs)
    #where inputs is an instance of a User_inputs
    @parsed_zip_code = inputs.zip_code
    @parsed_price = self.price_parse(inputs.min_price, inputs.max_price)
    @parsed_bedrooms = self.bedrooms_parse(inputs.bedrooms)
    @parsed_bathrooms = self.bathrooms_parse(inputs.bathrooms)
    @parsed_property_type = self.property_parse(inputs.property_type)
  end
#will probable need to change all the argument names to something else...  but will figure out later

  def price_parse(min_p, max_p)
    price = ""
    if min_p == nil && max_p == nil
      price = nil
    elsif min_p == nil && max_p != nil
      price = "price-na-#{max_p}"
    elsif min_p != nil && max_p == nil
      price = "price-#{min_p}-na"
    else
      price = "price-#{min_p}-#{max_p}"
    end
    price
  end

  def bedrooms_parse(bedrooms)
    beds = ""
    case bedrooms
    when nil
      beds = nil
    when "studio"
      beds = "beds-studio"
    when "1+"
      beds = "beds-1"
    when "2+"
      beds = "beds-2"
    when "3+"
      beds = "beds-3"
    when "4+"
      beds = "beds-4"
    when "5+"
      beds = "beds-5"
    end
    beds
  end

  def bathrooms_parse(bathrooms)
    baths = ""
    case bathrooms
    when nil
      baths = nil
    when "1+"
      baths = "baths-1"
    when "2+"
      baths = "baths-2"
    when "3+"
      baths = "baths-3"
    when "4+"
      baths = "baths-4"
    when "5+"
      baths = "baths-5"
    end
    baths
  end

  def property_parse(property_type)
    type = ""
    case property_type
    when nil
      type = nil
    when "single family home"
      type = "type-single-family-home"
    when "condos/townhomes/co-ops"
      type = "type-condo-townhome-row-home-co-op"
    when "mfd/mobile homes"
      type = "type-mfd-mobile-home"
    when "farms/ranches"
      type = "type-farms-ranches"
    when "land"
      type = "type-land"
    when "multi-family"
      type = "type-multi-family-home"
    end
    type
  end

end
