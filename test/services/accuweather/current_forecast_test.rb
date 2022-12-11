class Accuweather::CurrentForecastTest < ActiveSupport::TestCase
  test "fetch" do
    VCR.use_cassette("current_forecast_fetch") do
      current_forecast = Accuweather::CurrentForecast.fetch("3697_PC")

      assert_equal 17, current_forecast.keys.size
      assert current_forecast[:text].present?
    end
  end
end
