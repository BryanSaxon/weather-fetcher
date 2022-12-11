require "ruby_postal/parser"

# PostalCode
#
# This class is used to store the postal code data for a given location. The id
# is the postal code.
#
# PostalCodes are store in Redis to reduce the number of API calls to Accuweather.
class PostalCode < RedisRecord
  class << self
    # This method is used to find a record by its id. If the record is found, it builds
    # a new instance of the class and returns it. If the record is not found, it creates
    # a new record within Redis.
    def find_or_create(query)
      return if query.nil?

      id = parse(query)

      find(id) || create(*location_params(id || query))
    end

    private

    # The location_params method is used to find the location data for a given query
    # from Accuweather.
    def location_params(query)
      location = Accuweather::Location.search(query)

      [location[:postal_code], {key: location[:key], name: location[:name]}]
    end

    # The parse method is used to parse the query to find the postal code.
    # This reduces the burden on the Accuweather API and provides a more consistent
    # result than strictly relying on the first location returned from Accuweather.
    def parse(query)
      Postal::Parser.parse_address(query).find do |h|
        h[:label].eql?(:postcode)
      end&.dig(:value)
    end
  end
end
