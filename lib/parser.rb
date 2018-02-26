class Parser

  def self.parse_parameters(search_parameters)
    parsed_parameters = {
      parsed_zip_code: search_parameters.zip_code,
      parsed_bedrooms: bedrooms_parse(search_parameters),
      parsed_bathrooms: bathrooms_parse(search_parameters),
      parsed_property_type: property_type_parse(search_parameters),
      parsed_price_range: price_parse(search_parameters)
    }
  end

  def self.price_parse(search_parameters)
    min_p = search_parameters.min_price
    max_p = search_parameters.max_price
    price = ""
    if min_p == "0" && max_p == "any"
      price = nil
    elsif min_p == "0" && max_p != "any"
      price = "price-na-#{max_p}"
    elsif min_p != "0" && max_p == "any"
      price = "price-#{min_p}-na"
    else
      price = "price-#{min_p}-#{max_p}"
    end
    price
  end

  def self.bedrooms_parse(search_parameters)
    beds = ""
    case search_parameters.bedrooms
      when "any"
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

  def self.bathrooms_parse(search_parameters)
    baths = ""
    case search_parameters.bathrooms
      when "any"
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

  def self.property_type_parse(search_parameters)
    type = ""
    case search_parameters.property_type
      when "any"
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
