# Accuweather::Client
#
# This class is used to make raw requests to the Accuweather API.
module Accuweather
  class Client
    API_KEY = ENV["ACCUWEATHER_API_KEY"]
    BASE_URL = "http://dataservice.accuweather.com"

    class << self
      # This method is used to find the current forecast for a given location key.
      def current_conditions(location_key)
        get("#{BASE_URL}/currentconditions/v1/#{location_key}", details: true)
      end

      # This method is used to find the location given text.
      #
      # Locations can be found from cities, postal codes, addresses, points of interest
      # and other queries. This API was used over the postal code search API because it
      # provides a more robust solution for the same API result.
      def location_text_search(location_text)
        get("#{BASE_URL}/locations/v1/search", q: location_text, details: true)
      end

      private

      def get(url, query = nil)
        params = query.nil? ? base_params : base_params.merge(query)

        HTTParty.get(url, query: params)
      end

      def base_params
        {apikey: API_KEY}
      end
    end
  end
end
