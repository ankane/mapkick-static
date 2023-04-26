# Mapkick Static

Create beautiful static maps with one line of Ruby. No more fighting with mapping libraries!

[See it in action](https://chartkick.com/mapkick-static)

:fire: For JavaScript maps, check out [Mapkick](https://chartkick.com/mapkick)

[![Build Status](https://github.com/ankane/mapkick-static/workflows/build/badge.svg?branch=master)](https://github.com/ankane/mapkick-static/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "mapkick-static"
```

Mapkick Static uses the [Mapbox Static Images API](https://docs.mapbox.com/api/maps/static-images/). [Create a Mapbox account](https://account.mapbox.com/auth/signup/) to get an access token and set `ENV["MAPBOX_ACCESS_TOKEN"]` in your environment.

## Maps

Point map

<img src="https://chartkick.com/mapkick-static/map-2x?v2" alt="Map" width="800" height="400">

```erb
<%= static_map [{latitude: 37.7829, longitude: -122.4190}] %>
```

Area map (experimental)

```erb
<%= static_area_map [{geometry: {type: "Polygon", coordinates: ...}}] %>
```

## Data

Data can be an array

```erb
<%= static_map [{latitude: 37.7829, longitude: -122.4190}] %>
```

### Point Map

Use `latitude` or `lat` for latitude and `longitude`, `lon`, or `lng` for longitude

You can specify a color for each data point

```ruby
{
  latitude: ...,
  longitude: ...,
  color: "#f84d4d"
}
```

### Area Map

Use `geometry` with a GeoJSON `Polygon` or `MultiPolygon`

You can specify a color for each data point

```ruby
{
  geometry: {type: "Polygon", coordinates: ...},
  color: "#0090ff"
}
```

## Options

Width and height

```erb
<%= static_map data, width: 800, height: 500 %>
```

Alt text

```erb
<%= static_map data, alt: "Map of ..." %>
```

Marker color

```erb
<%= static_map data, markers: {color: "#f84d4d"} %>
```

Map style

```erb
<%= static_map data, style: "mapbox/outdoors-v12" %>
```

## History

View the [changelog](https://github.com/ankane/mapkick-static/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/mapkick-static/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/mapkick-static/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/mapkick-static.git
cd mapkick-static
bundle install
bundle exec rake test
```
