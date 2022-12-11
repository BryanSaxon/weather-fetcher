# Accuweather::Location
#
# This class is used to find the location data for a given search query.
#
# It is a wrapper around the Accuweather::Client class to map the attributes
# of interest that are used in the application to generate a PostalCode model.
module Accuweather
  class Location
    def self.search(query)
      response = Accuweather::Client.location_text_search(query)

      if response.success?
        result = response.parsed_response.first

        if result.present?
          {
            key: result["Key"],
            postal_code: result["PrimaryPostalCode"],
            name: result["EnglishName"]
          }
        end
      else
        raise "Accuweather::Location.search failed with #{response.code}"
      end
    end
  end
end
