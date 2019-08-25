Geocoder.configure(
  # geocoding service
  # lookup: :nominatim,
  lookup: :yandex,
  api_key: ENV['YANDEX_API_KEY'],
  use_https: true,

  # geocoding service request timeout (in seconds)
  timeout: 5,

  # default units
  units: :km
)