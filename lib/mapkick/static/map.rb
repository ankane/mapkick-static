module Mapkick
  module Static
    class Map < BaseMap
      private

      def generate_features(data, default_color)
        default_color ||= "#f84d4d"
        default_icon = nil

        data.group_by { |v| [v["color"] || default_color, v["x_icon"] || default_icon] }.map do |(color, icon), vs|
          geometry = {
            type: "MultiPoint",
            coordinates: vs.map { |v| row_coordinates(v).map { |vi| round_coordinate(vi) } }
          }

          properties = {
            "marker-color" => color
          }
          properties["marker-symbol"] = icon if icon

          {
            type: "Feature",
            geometry: geometry,
            properties: properties
          }
        end
      end

      def row_coordinates(row)
        [row["longitude"] || row["lng"] || row["lon"], row["latitude"] || row["lat"]]
      end
    end
  end
end
