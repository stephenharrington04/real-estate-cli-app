class Parse

#will probable need to change all the argument names to something else...  but will figure out later

#zipcode should be fine the way it is.  Not sure if I'll even need a method for it, but will keep for now.
  def zip_code(zip_code)
    zip_code
  end

  def price_parse(min_price, max_price)
    if min_price == nil && max_price == nil
      nil
    elsif min_price == nil && max_price != nil
      "price-na-#{max_price}"
    elsif min_price != nil && max_price == nil
      "price-#{min_price}-na"
    end
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
