class ForecastCacheTest < ActiveSupport::TestCase
  test "store" do
    VCR.use_cassette("forecast_cache_store") do
      forecast = ForecastCache.store("10001")

      assert_equal "10001", forecast.id
    end
  end
end
