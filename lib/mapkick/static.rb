# stdlib
require "cgi"
require "json"
require "uri"

# maps
require_relative "static/base_map"
require_relative "static/area_map"
require_relative "static/map"

# modules
require_relative "static/helper"
require_relative "static/version"

if defined?(ActiveSupport.on_load)
  ActiveSupport.on_load(:action_view) do
    include Mapkick::Static::Helper
  end

  ActiveSupport.on_load(:action_mailer) do
    include Mapkick::Static::Helper
  end
end

module Mapkick
  module Static
    class Error < StandardError; end
  end
end
