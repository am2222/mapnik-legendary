# encoding: utf-8

require 'mapnik_legendary/part'

module MapnikLegendary
  # A feature has a name, description, and one or more parts holding geometries, tags and layers
  class Feature
    attr_reader :name, :parts, :description

    def initialize(feature, zoom, map, extra_tags)
      @name = feature['name']
      @description = feature.key?('description') ? feature['description'] : @name.capitalize
      @parts = []
      if feature.key? 'parts'
        feature['parts'].each do |part|
          @parts << Part.new(part, zoom, map, extra_tags)
        end
      else
        @parts << Part.new(feature, zoom, map, extra_tags)
      end
    end

    def envelope
      @parts.first.geom.envelope
    end
  end
end
