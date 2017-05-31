require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

################## SEARCH QUERY SCRAPER FUNCTIONS ########################

  def self.search_results_scraper(results_url)
    listings_info = []
    doc = Nokogiri::HTML(open(results_url))
    doc.css("ul.srp-list-marginless").css("li").each do |listing|
      listing_url = "http://www.realtor.com"
      address_noko = listing.css(".srp-item-body").css(".srp-item-address")
      street_address = address_noko.css(".listing-street-address").text
      city_address = address_noko.css(".listing-city").text
      state_address = address_noko.css(".listing-region").text
      postal_address = address_noko.css(".listing-postal").text
      listing_address = "#{street_address} #{city_address}, #{state_address}, #{postal_address}"
      listing_price = listing.css(".srp-item-body").css(".srp-item-price").css(".data-price-display").text
      listing_num_beds = listing.css(".srp-item-body").css(".srp-item-property-meta").css("ul").css("li").css("span.data-value.meta-beds").text
      listing_prop_type = listing.css(".srp-item-body").css(".srp-item-details").css(".srp-item-type").css("span").text
      listing_num_baths = listing.css(".srp-item-body").css(".srp-item-property-meta").css("ul").css("li[data-label='property-meta-baths']").css("span").text
      if listing.css(".srp-item-body").css(".srp-item-details a").first != nil
        listing_url << listing.css(".srp-item-body").css(".srp-item-details a").first["href"]
      end
      listings_info << {address: listing_address, price: listing_price, beds: listing_num_beds, baths: listing_num_baths, property_type: listing_prop_type, house_url: listing_url} if listing_address != " , , "
    end
    listings_info
  end

################## INDIVIDUAL HOUSE SCRAPER FUNCTIONS ############################################

  def self.listing_scraper(listing_url)
    listing_info = {}
    facts = []
    doc = Nokogiri::HTML(open(listing_url))
    basic_noko = doc.css(".page-content").css(".container-ldp").css(".container").css(".row-wrapper-detail").css(".row").css(".col-lg-9")
    detailed_noko = basic_noko.css(".listing-section").css(".listing-subsection")
    detailed_noko.css(".ldp-detail-key-facts").css("ul").css("li").css(".key-fact-data").each do |fact|
      facts << fact.text
    end
    basic_noko.css(".listing-header").css(".listing-header-main").css(".row").css(".col-sm-7").css(".pull-left").css(".ldp-header-meta").css("ul").css("li").css("span").each do |item|
      facts << item.text
    end
    listing_info[:address] = basic_noko.css(".listing-header").css(".listing-header-main").css(".row").css(".col-sm-7").css(".pull-left").css(".ldp-header-address-wrapper").first.children.css("div").first.attr("content")
    listing_info[:beds] = facts[5]
    listing_info[:baths] = facts[6]
    listing_info[:sqft] = facts[7]
    listing_info[:acres] = facts[8]
    listing_info[:status] = facts[0]
    listing_info[:price_per_sqft] = facts[1]
    listing_info[:days_on_market] = facts[2]
    listing_info[:year_built] = facts [3]
    listing_info[:property_type] = facts [4]
    listing_info[:description] = detailed_noko.css(".margin-top-lg").css("p").first.text
    listing_info
  end

end
