module Mapping
  class Export < Base
    class << self
      attr_accessor :folder_name, :filename, :entity_class

      def call!(options)
        @folder_name = options[:export_folder]

        FileUtils.mkdir(folder_name) unless Dir.exist?(folder_name)

        Current.company = Company.find_by(id: options[:company_id]) || Company.first

        POSSIBLE_CSV_DEFINITIONS[options[:mapping_definition]].each do |filename|
          @filename = filename

          puts filename

          begin
            @entity_class = get_entity_class
            export_file_path = [folder_name, filename].join('/')

            CSV.open(export_file_path, 'w') do |file|
              file << entity_class.export_file_headers

              entity_class.internal_model.find_each do |record|
                file << entity_class.export(record.attributes)
              end
            end
          rescue NameError
            raise "Mapping for #{filename} is not defined!"
          end
        end
      end

      private
        def file_extension
          File.extname(filename)
        end

        def file_basename
          File.basename(filename, '.csv')
        end

        def get_entity_class
          klass = file_basename.singularize.camelize

          "Entities::#{klass}".constantize
        end
    end
  end
end
