class Formatter

  def self.format_parameters(search_parameters)
    formatted_parameters = {
      formatted_zip_code: search_parameters.zip_code,
      formatted_bedrooms: format_bedrooms(search_parameters),
      formatted_bathrooms: format_bathrooms(search_parameters),
      formatted_property_type: format_property_type(search_parameters),
      formatted_price_range: format_price(search_parameters)
    }
  end

  def self.format_price(search_parameters)
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

  def self.format_bedrooms(search_parameters)
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

  def self.format_bathrooms(search_parameters)
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

  def self.format_property_type(search_parameters)
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
