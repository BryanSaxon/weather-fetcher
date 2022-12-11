class ForecastCache
  def self.store(id)
    postal_code = PostalCode.find_or_create(id)
    params = Accuweather::CurrentForecast.fetch(postal_code&.key)

    Forecast.create(id, params, expire_in: 1800) if params.present?
  end
end
