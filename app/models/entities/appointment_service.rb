module Entities
  class AppointmentService < Entity
    class << self
      def internal_entity_name
        'AppointmentService'
      end

      def external_entity_name
        'AppointmentService'
      end

      def mapper
        AppointmentServiceMapper
      end
    end
  end
end

class AppointmentServiceMapper
  extend HashMapper

  map from('id'), to('reference_id')

  after_normalize do |input, output|
    output['service_id'] = Service.find_by(reference_id: input['service_id'])&.id
    output['appointment_id'] = Appointment.find_by(reference_id: input['appointment_id'])&.id

    output
  end
end
