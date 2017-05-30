require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
################## SEARCH QUERY SCRAPER FUNCTIONS ########################

  def url_scraper(url)
    doc = Nokogiri::HTML(open(url))
    urls = []
    counter = 1
    until counter == 16
      house_url = "http://www.realtor.com"
      house_url << doc.css("ul.srp-list-marginless").css("li").css("div##{counter}.js-record-user-activity.js-navigate-to.srp-item").attr("data-url").value
      urls << house_url
      counter += 1
    end
    urls
  end

  def baths_scraper(url)
    doc = Nokogiri::HTML(open(url))
    baths = []
    counter = 1
    until counter == 16
      baths << doc.css("ul.srp-list-marginless").css("li").css("div##{counter}.js-record-user-activity.js-navigate-to.srp-item").attr("data-baths_full").value
      counter += 1
    end
    baths
  end

  def index_scraper(index_url)
    counter = 0
    house_info = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("ul.srp-list-marginless").css("li").each do |listing|
      street_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-street-address").text
      city_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-city").text
      state_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-region").text
      postal_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-postal").text
      home_address = "#{street_address} #{city_address}, #{state_address}, #{postal_address}"
      home_price = listing.css(".srp-item-body").css(".srp-item-price").css(".data-price-display").text
      home_num_beds = listing.css(".srp-item-body").css(".srp-item-property-meta").css("ul").css("li").css("span.data-value.meta-beds").text
      house_info << {address: home_address, price: home_price, beds: home_num_beds} if home_address != " , , "
    end
    house_info.each do |hash|
      hash[:baths] = baths_scraper(index_url)[counter]
      hash[:house_url] = url_scraper(index_url)[counter]
      counter += 1
    end
    house_info
  end

################## INDIVIDUAL HOUSE SCRAPER FUNCTIONS ############################################

  def basic_info_scraper(listing_url)
    data = {}
    info = []
    doc = Nokogiri::HTML(open(listing_url))
    main = doc.css(".page-content").css(".container-ldp").css(".container").css(".row-wrapper-detail").css(".row").css(".col-lg-9").css(".listing-header").css(".listing-header-main").css(".row").css(".col-sm-7").css(".pull-left")
    sections = main.css(".ldp-header-meta").css("ul").css("li")
    sections.css("span").each do |item|
      info << item.text
    end
    data[:address] = main.css(".ldp-header-address-wrapper").first.children.css("div").first.attr("content")
    data[:beds] = info[0]
    data[:baths] = info[1]
    data[:sqft] = info[2]
    data[:acres] = info[3]
    binding.pry
  end

  def listing_scraper(listing_url)
    listing_info = {}
    facts = []
    doc = Nokogiri::HTML(open(listing_url))
    basic_noko = doc.css(".page-content").css(".container-ldp").css(".container").css(".row-wrapper-detail").css(".row").css(".col-lg-9").css(".listing-section")
    detailed_noko = basic_noko.css(".listing-subsection")
    detailed_noko.css(".ldp-detail-key-facts").css("ul").css("li").css(".key-fact-data").each do |fact|
      facts << fact.text
    end
    listing_info[:address] = basic_noko.css("h2").css("span.visible-lg-inline").text.gsub("for ", "")
    listing_info[:status] = facts[0]
    listing_info[:price_per_sqft] = facts[1]
    listing_info[:days_on_market] = facts[2]
    listing_info[:year_built] = facts [3]
    listing_info[:property_type] = facts [4]
    listing_info[:description] = detailed_noko.css(".margin-top-lg").css("p").first.text
    listing_info
  end

end

m = Scraper.new
#m.index_scraper("http://www.realtor.com/realestateandhomes-search/67037/beds-1/type-single-family-home/price-250000-400000")
#m.url_scraper("http://www.realtor.com/realestateandhomes-search/67037/beds-1/type-single-family-home/price-250000-400000")
m.basic_info_scraper("http://www.realtor.com/realestateandhomes-detail/929-E-Lost-Hills-Ct_Derby_KS_67037_M74395-08416")
