require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"

ENV["MAPBOX_ACCESS_TOKEN"] ||= "pk.token"
