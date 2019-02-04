module Entities
  class Entity
    class << self
      def internal_entity_name
        raise 'Not implemented!'
      end

      def internal_model
        internal_entity_name.constantize
      end

      def external_entity_name
        raise 'Not implemented!'
      end

      def mapper
        raise 'Not implemented!'
      end

      def import(params)
        record = internal_model.new mapper.normalize(params)

        record.save && success_response || failure_response(record)
      end

      def success_response
        { status: :success }
      end

      def failure_response record
        { status: :failure, message: record.errors.full_messages.to_sentence }
      end
    end
  end
end
