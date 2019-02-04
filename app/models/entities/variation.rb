module Entities
  class Variation < Entity
    class << self
      def internal_entity_name
        'Service'
      end

      def external_entity_name
        'Variation'
      end

      def mapper
        VariationMapper
      end
    end
  end
end

class VariationMapper
  extend HashMapper

  map from('id'), to('reference_id')
  map from('title'), to('name')
end
