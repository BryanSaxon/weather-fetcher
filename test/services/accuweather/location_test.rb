class Accuweather::LocationTest < ActiveSupport::TestCase
  test "find" do
    VCR.use_cassette("location_find") do
      location = Accuweather::Location.search("131 W 55th Street New York, NY 10019")

      assert_equal 3, location.keys.size
      assert location[:key].present?
    end
  end
end
