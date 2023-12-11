require_relative "test_helper"

class MapTest < Minitest::Test
  include Mapkick::Static::Helper

  def setup
    @data = [{latitude: 1.23, longitude: 4.56}]
  end

  def test_static_map
    assert_map static_map(@data)
  end

  def test_static_map_empty
    assert_map static_map([])
  end

  def test_static_area_map
    assert_map static_area_map([])
  end

  def test_invalid_style
    error = assert_raises(ArgumentError) do
      static_map(@data, style: "custom")
    end
    assert_equal "Invalid style", error.message
  end

  def test_secret_token
    error = assert_raises(Mapkick::Static::Error) do
      static_map(@data, access_token: "sk.token")
    end
    assert_equal "Expected public access token", error.message
  end

  def test_invalid_token
    error = assert_raises(Mapkick::Static::Error) do
      static_map(@data, access_token: "token")
    end
    assert_equal "Invalid access token", error.message
  end

  def test_no_token
    ENV.stub(:[], nil) do
      error = assert_raises(Mapkick::Static::Error) do
        static_map(@data)
      end
      assert_equal "No access token", error.message
    end
  end

  def test_request_too_large
    data = 265.times.map { {latitude: rand, longitude: rand} }
    assert_output(nil, /URL exceeds 8192 byte limit/) do
      static_map(data)
    end
  end

  private

  def assert_map(map)
    assert_kind_of Mapkick::Static::BaseMap, map
    assert_match "https://api.mapbox.com/", map.url
    system "open", map.url if ENV["OPEN"]
  end
end
