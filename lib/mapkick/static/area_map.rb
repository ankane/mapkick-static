module Mapkick
  module Static
    class AreaMap < BaseMap
      private

      def generate_features(data, default_color)
        default_color ||= "#0090ff"

        data.map do |v|
          color = v["color"] || default_color
          {
            type: "Feature",
            # TODO round coordinates
            geometry: v["geometry"],
            properties: {
              "fill" => color,
              "fill-opacity" => 0.3,
              "stroke" => color,
              "stroke-width" => 1,
              "stroke-opacity" => 0.7
            }
          }
        end
      end
    end
  end
end
