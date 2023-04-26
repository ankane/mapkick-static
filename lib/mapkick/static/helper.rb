module Mapkick
  module Static
    module Helper
      def static_map(data, **options)
        Mapkick::Static::Map.new(data, **options, view_context: self)
      end

      def static_area_map(data, **options)
        Mapkick::Static::AreaMap.new(data, **options, view_context: self)
      end
    end
  end
end
