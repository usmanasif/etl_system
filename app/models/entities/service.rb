module Entities
  class Service < Entity
    class << self
      def internal_entity_name
        'Service'
      end

      def external_entity_name
        'Service'
      end

      def mapper
        ServiceMapper
      end
    end
  end
end

class ServiceMapper
  extend HashMapper

  map from('id'), to('reference_id')
  map from('name'), to('name')
end
