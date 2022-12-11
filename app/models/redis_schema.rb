# RedisSchema
#
# This file acts as the schema for the Redis database. It is used to
# determine which keys are available for each model.
module RedisSchema
  FORECAST = %i[
    text icon temperature temperature_unit daytime
    precipitation precipitation_type wind_speed wind_speed_unit
    wind_direction dewpoint dewpoint_unit relative_humidity visability
    visability_unit uv_index uv_index_text
  ]

  POSTAL_CODE = %i[id key name]
end
