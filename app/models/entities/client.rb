module Entities
  class Client < Entity
    class << self
      def internal_entity_name
        'Client'
      end

      def external_entity_name
        'Client'
      end

      def mapper
        ClientMapper
      end
    end
  end
end

class ClientMapper
  extend HashMapper

  map from('name'), to('name')
  map from('email'), to('email')
end
