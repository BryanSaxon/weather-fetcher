# Weather Fetcher

## Goal

This codebase is meant to fulfill a coding challenge.

### Requirements

1. Must be done in Ruby on Rails.
2. Accept an address as input.
3. Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast).
4. Display the requested forecast details to the user.
5. Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
6. Display indicator if result is pulled from cache.

### Assumptions

1. This project is open to interpretation.
2. Functionality is a priority over form.
3. If you get stuck, complete as much as you can.

## Setup

This setup assumes you are running the application locally with MacOS.

### Environment Variables

#### Accuweather

To run the application, you need an API key for Accuweather. You can get a key [here](https://developer.accuweather.com/).

Once you have a key, you need to create a `.env` file in the root directory. In that file, you should add the following environment variable with you own key:

```bash
ACCUWEATHER_API_KEY=your_key_from_accuweather
```

### Dependencies

#### Redis

Redis is used as the sole datastore for the application. Since the source of truth for the data displayed in the application belongs to Accuweather, a simple cache of the data requested is all that is needed. To install Redis, you should run the following command in your terminal:

```bash
brew install redis
```

#### libpostal

> libpostal is a C library for parsing/normalizing street addresses around the world using statistical NLP and open data. The goal of this project is to understand location-based strings in every language, everywhere.

`libpostal` was used in the project to help reduce the amount of API calls to Accuweather's API.

To install `libpostal`, you must first install it's dependancies:

```bash
sudo brew install curl autoconf automake libtool pkg-config
```

Once the dependancies are installed, you can install `libpostal`.

```bash
git clone https://github.com/openvenues/libpostal
cd libpostal
./bootstrap.sh
./configure --datadir=[...some dir with a few GB of space...]
make
sudo make install
```

#### Rails

Once the other the environment variables and other dependancies are installed, you can run the following commands to setup the application:

```bash
bundle install
```

## Running the Application

```bash
foreman start -f Procfile.dev
```

## Design

Below are brief descriptions of the core business logic for the Weather Fetcher application.

Additional information can be found in comments within the codebase.

### Models

*RedisSchema*
`RedisSchema` is the "schema" that defines the attributes for the models stored in Redis.

*RedisRecord*
`RedisRecord` is the parent class for all Redis models. This provides a consistent way to store and access records within Redis

*PostalCode*
`PostalCode` allows for caching location keys for Accuweather current forecast lookups.

`PostalCode` inherits from `RedisRecord`.

*Forecast*
`Forecast` is the model that caches forecast data for a given postal code. The cache is stored for 30 minutes (1800 seconds).

`Forecast` inherits from `RedisRecord`.

### Services

#### Accuweather

*Client*

The `Client` class handles API requests to Accuweather.

*Location*

The `Location` class is used for searching for locations given a query. This class also maps the API response to the parameter format expected by the `PostalCode` model.

*CurrentForecast*

The `CurrentForecast` class is used for fetching the current forecast for given a Accuweather location key. This class also maps the API response to the parameter format expected by the `Forecast` model.
