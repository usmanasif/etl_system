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

      def import(params)
        record = internal_model.new mapper.normalize(params)

        record.save && success_response || failure_response(record)
      end
    end
  end
end

class ClientMapper
  extend HashMapper

  map from('name'), to('name')
  map from('email'), to('email')
end
