module Entities
  class EventVariation < Entity
    class << self
      def internal_entity_name
        'AppointmentService'
      end

      def external_entity_name
        'EventVariation'
      end

      def mapper
        EventVariationMapper
      end
    end
  end
end

class EventVariationMapper
  extend HashMapper

  map from('id'), to('reference_id')

  after_normalize do |input, output|
    output['service_id'] = Service.find_by(reference_id: input['variation_id'])&.id
    output['appointment_id'] = Appointment.find_by(reference_id: input['event_id'])&.id

    output
  end
end
