class Parse

#zipcode should be fine the way it is.



#min_price and max_price will combine into one segment
  #if min_price = nil & max_price = nil, price = nil
  #if min_price = nil & max price = something, price = price-na-something
  #if min_price = something & max price = nil, price = price-something-na



#if bedrooms = nil, beds = nil
#if bedrooms = studio, beds = beds-studio
#if bedrooms = 1+, beds = beds-1
#if bedrooms = 2+, beds = beds-2
#if bedrooms = 3+, beds = beds-3
#if bedrooms = 4+, beds = beds-4
#if bedrooms = 5+, beds = beds-5


#if bathrooms = nil, baths = nil
#if bathrooms = 1+, baths = baths-1
#if bathrooms = 2+, baths = baths-2
#if bathrooms = 3+, baths = baths-3
#if bathrooms = 4+, baths = baths-4
#if bathrooms = 5+, baths = baths-5


# if property_type = nil, type = nil
# if property_type = single family home, type = type-single-family-home
# if property_type = condos/townhomes/co-ops, type = type-condo-townhome-row-home-co-op
# if property_type = mfd/mobile homes, type = type-mfd-mobile-home
# if property_type = farms/ranches, type = type-farms-ranches
# if property_type = land, type = type-land
# if property_type = multi-family, type = type-multi-family-home



end
