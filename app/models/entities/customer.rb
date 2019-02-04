module Entities
  class Customer < Entity
    class << self
      def internal_entity_name
        'Client'
      end

      def external_entity_name
        'Customer'
      end

      def mapper
        CustomerMapper
      end
    end
  end
end

class CustomerMapper
  extend HashMapper

  map from('id'), to('reference_id')
  map from('email'), to('email')

  after_normalize do |input, output|
    output['name'] = [input['first_name'], input['last_name']].join(' ')
    output
  end
end
