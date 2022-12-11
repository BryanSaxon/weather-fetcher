# Accuweather::CurrentForecast
#
# This class is used to fetch the current forecast for a given location key.
#
# It is a wrapper around the Accuweather::Client class to map the attributes
# of interest that are used in the application to generate a Forecast model.
module Accuweather
  class CurrentForecast
    def self.fetch(location_key)
      return unless location_key.present?

      response = Accuweather::Client.current_conditions(location_key)

      if response.success?
        result = response.parsed_response.first

        {
          text: result["WeatherText"],
          icon: result["WeatherIcon"],
          temperature: result.dig("Temperature", "Imperial", "Value"),
          temperature_unit: result.dig("Temperature", "Imperial", "Unit"),
          daytime: result["IsDayTime"],
          precipitation: result["HasPrecipitation"],
          precipitation_type: result["PrecipitationType"],
          wind_speed: result.dig("Wind", "Speed", "Imperial", "Value"),
          wind_speed_unit: result.dig("Wind", "Speed", "Imperial", "Unit"),
          wind_direction: result.dig("Wind", "Direction", "English"),
          dewpoint: result.dig("DewPoint", "Imperial", "Value"),
          dewpoint_unit: result.dig("DewPoint", "Imperial", "Unit"),
          relative_humidity: result["RelativeHumidity"],
          visability: result.dig("Visibility", "Imperial", "Value"),
          visability_unit: result.dig("Visibility", "Imperial", "Unit"),
          uv_index: result["UVIndex"],
          uv_index_text: result["UVIndexText"]
        }
      else
        raise "Accuweather::Forecast.current failed with #{response.code}"
      end
    end
  end
end
