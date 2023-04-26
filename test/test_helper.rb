require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

ENV["MAPBOX_ACCESS_TOKEN"] ||= "pk.token"
