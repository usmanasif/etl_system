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
        mapped_params = mapper.normalize(params)
        existed_record = internal_model.find_by(reference_id: mapped_params[:reference_id])

        if existed_record.present?
          old_attributes = existed_record.attributes

          existed_record.update(mapped_params.except(:reference_id))

          if existed_record.attributes == old_attributes
            not_changed_response
          else
            updated_response
          end
        else
          record = internal_model.new mapped_params

          record.save && created_response || failure_response(record)
        end
      end

      def export_file_headers
        mapper.denormalize(internal_model.first.attributes).keys
      end

      def export(params)
        mapper.denormalize(params).values
      end

      def created_response
        { status: :success, message: :created }
      end

      def updated_response
        { status: :success, message: :updated }
      end

      def failure_response record
        { status: :failure, message: record.errors.full_messages.to_sentence }
      end

      def not_changed_response
        { status: :failure, message: :not_changed }
      end
    end
  end
end
