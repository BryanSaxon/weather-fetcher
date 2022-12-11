class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    VCR.use_cassette("forecasts_show") do
      get forecast_url("10019")

      assert_response :success
    end
  end
end
