# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
      The command_line_interface.rb asks the user for inputs throughout the app
      - It creates an instance of search_parameters, passes that object to a formatter, then to a url_creator to create a URL
      - The CLI creates instances of Listings based on a Scraper which uses the aforementioned URL
      - The CLI displays search results
- [x] Pull data from an external source
      The scraper.rb pulls data from Realtor.com based on search parameters entered by the user.
- [x] Implement both list and detail views
      The command_line_interface displays 15 results that match the user's inputs.  The user can then select an individual listing from this list.  The details
      of that individual listing are then displayed.
