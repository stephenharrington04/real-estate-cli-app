class Parse

#will probable need to change all the argument names to something else...  but will figure out later

#zipcode should be fine the way it is.  Not sure if I'll even need a method for it, but will keep for now.
  def zip_code(zip_code)
    zip_code
  end

#min_price and max_price will combine into one segment
  #if min_price = nil & max_price = nil, price = nil
  #if min_price = nil & max price = something, price = price-na-something
  #if min_price = something & max price = nil, price = price-something-na
  def price_parse(min_price, max_price)
    if min_price == nil && max_price == nil
      nil
    elsif min_price == nil && max_price != nil
      "price-na-#{max_price}"
    elsif min_price != nil && max_price == nil
      "price-#{min_price}-na"
    end
  end

#if bedrooms = nil, beds = nil
#if bedrooms = studio, beds = beds-studio
#if bedrooms = 1+, beds = beds-1
#if bedrooms = 2+, beds = beds-2
#if bedrooms = 3+, beds = beds-3
#if bedrooms = 4+, beds = beds-4
#if bedrooms = 5+, beds = beds-5
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

#if bathrooms = nil, baths = nil
#if bathrooms = 1+, baths = baths-1
#if bathrooms = 2+, baths = baths-2
#if bathrooms = 3+, baths = baths-3
#if bathrooms = 4+, baths = baths-4
#if bathrooms = 5+, baths = baths-5
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

# if property_type = nil, type = nil
# if property_type = single family home, type = type-single-family-home
# if property_type = condos/townhomes/co-ops, type = type-condo-townhome-row-home-co-op
# if property_type = mfd/mobile homes, type = type-mfd-mobile-home
# if property_type = farms/ranches, type = type-farms-ranches
# if property_type = land, type = type-land
# if property_type = multi-family, type = type-multi-family-home



end
