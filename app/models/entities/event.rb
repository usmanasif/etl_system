module Entities
  class Event < Entity
    class << self
      def internal_entity_name
        'Appointment'
      end

      def external_entity_name
        'Event'
      end

      def mapper
        EventMapper
      end
    end
  end
end

class EventMapper
  extend HashMapper

  map from('id'), to('reference_id')
  map from('start_time'), to('begin_at')
  map from('end_time'), to('end_at')

  after_normalize do |input, output|
    output['client_id'] = Client.find_by(reference_id: input['customer_id'])&.id
    output
  end

  after_normalize do |input, output|
    output['customer_id'] = Client.find_by(id: input['client_id'])&.reference_id
    output
  end
end
