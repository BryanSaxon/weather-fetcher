class PostalCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postal_codes_url

    assert_response :success
  end

  test "should find/create a postal code" do
    VCR.use_cassette("postal_codes_create") do
      post postal_codes_url, params: {query: "131 W 55th Street New York, NY 10019"}

      assert_redirected_to forecast_path("10019")
    end
  end
end
