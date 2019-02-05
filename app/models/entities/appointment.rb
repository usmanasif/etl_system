module Entities
  class Appointment < Entity
    class << self
      def internal_entity_name
        'Appointment'
      end

      def external_entity_name
        'Appointment'
      end

      def mapper
        AppointmentMapper
      end
    end
  end
end

class AppointmentMapper
  extend HashMapper

  map from('id'), to('reference_id')
  map from('begin_at'), to('begin_at')
  map from('end_at'), to('end_at')

  after_normalize do |input, output|
    output['client_id'] = Client.find_by(reference_id: input['client_id'])&.id
    output
  end

  after_denormalize do |input, output|
    output['client_id'] = Client.find_by(id: input['client_id'])&.reference_id
    output
  end
end
