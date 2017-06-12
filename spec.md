# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
      The command_line_interface.rb and user_inputs.rb ask the user for inputs throughout the app.
      - User_inputs.rb creates an object of search parameters in which a url is created.
      - The command_line_interface.rb displays search results
- [x] Pull data from an external source
      The scraper.rb pulls data from Realtor.com based on search parameters entered by the user.
- [x] Implement both list and detail views
      The command_line_interface displays 15 results that match the user's inputs.  The user can then select an individual listing from this list.  The details
      of that individual listing are then displayed.
