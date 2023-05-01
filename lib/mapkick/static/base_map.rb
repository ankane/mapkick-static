module Mapkick
  module Static
    class BaseMap
      attr_reader :url, :url_2x

      def initialize(data, width: 800, height: 500, markers: {}, style: "mapbox/streets-v12", alt: "Map", access_token: nil, view_context: nil)
        @width = width.to_i
        @height = height.to_i
        @alt = alt
        @view_context = view_context

        prefix = "https://api.mapbox.com/styles/v1"
        style = set_style(style)
        geojson = create_geojson(data, markers)
        overlay = "geojson(#{CGI.escape(JSON.generate(geojson))})"
        viewport = set_viewport(geojson)
        size = "%dx%d" % [@width.to_i, @height.to_i]
        query = set_query(access_token, viewport)

        url = "#{prefix}/#{style}/static/#{overlay}/#{viewport}/#{size}"
        @url = "#{url}?#{query}"
        @url_2x = "#{url}@2x?#{query}"

        check_request_size
      end

      def to_s
        @view_context.image_tag(url, alt: @alt, style: image_style, srcset: "#{url} 1x, #{url_2x} 2x")
      end

      private

      def set_style(style)
        style = style.delete_prefix("mapbox://styles/")
        if style.count("/") != 1
          raise ArgumentError, "Invalid style"
        end
        style.split("/", 2).map { |v| CGI.escape(v) }.join("/")
      end

      def create_geojson(data, markers)
        data = data.map { |v| v.transform_keys(&:to_s) }
        default_color = markers.transform_keys(&:to_s)["color"]
        {
          type: "FeatureCollection",
          features: generate_features(data, default_color)
        }
      end

      def set_viewport(geojson)
        if geojson[:features].empty?
          "0,0,1"
        elsif geojson[:features].size == 1 && (geometry = geojson[:features][0][:geometry]) && geometry&.[](:type) == "MultiPoint" && geometry[:coordinates].size == 1
          coordinates = geometry[:coordinates][0]
          zoom = 15
          "%f,%f,%d" % [round_coordinate(coordinates[0].to_f), round_coordinate(coordinates[1].to_f), zoom.to_i]
        else
          "auto"
        end
      end

      def set_query(access_token, viewport)
        params = {}
        params[:access_token] = check_access_token(access_token || ENV["MAPBOX_ACCESS_TOKEN"])
        if viewport == "auto"
          params[:padding] = 40
        end
        URI.encode_www_form(params)
      end

      def check_access_token(access_token)
        if !access_token
          raise Error, "No access token"
        elsif access_token.start_with?("sk.")
          # can bypass with string keys
          # but should help prevent common errors
          raise Error, "Expected public access token"
        elsif !access_token.start_with?("pk.")
          raise Error, "Invalid access token"
        end
        access_token
      end

      # round to reduce URL size
      def round_coordinate(point)
        point.round(7)
      end

      # https://docs.mapbox.com/api/overview/#url-length-limits
      def check_request_size
        if @url_2x.bytesize > 8192
          warn "[mapkick-static] URL exceeds 8192 byte limit of API (#{@url_2x.bytesize} bytes)"
        end
      end

      def image_style
        "width: %dpx; height: %dpx;" % [@width.to_i, @height.to_i]
      end
    end
  end
end
