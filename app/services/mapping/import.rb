module Mapping
  class Import < Base
    class << self
      attr_accessor :folder_name, :filename, :changes_are_made, :file_headers, :track_changes

      def call!(directory, mapping_definition=:csv_mapping_1)
        @folder_name = directory

        POSSIBLE_CSV_DEFINITIONS[mapping_definition].each do |filename|
          @filename = filename
          @track_changes = []

          begin
            import_file
            generate_report

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

        def import_file
          entity_class = get_entity_class
          file_path = File.join(folder_name, filename)

          loaded_csv = CSV.read(file_path, headers: true)
          @file_headers = loaded_csv.headers

          loaded_csv.each do |row|
            response = entity_class.import(row.to_h)

            if response[:status] == :success
              @changes_are_made ||= true

              track_changes << row.fields + [response[:status]]
            else
              track_changes << row.fields + [response[:message]]
            end
          end
        end

        def generate_report
          file_headers.map! { |value| value == 'id' && 'reference_id' || value }.push('Error/Success')
          reports_folder_name = ['csv_files_1', 'reports'].join('_')
          report_filename = [file_basename, '_report', file_extension].join
          report_file_path = [reports_folder_name, report_filename].join('/')

          FileUtils.mkdir(reports_folder_name) unless Dir.exist?(reports_folder_name)

          CSV.open(report_file_path, 'w') do |file|
            file << if changes_are_made
              ['Changes had been done']
            else
              ['No changes had been done']
            end

            file << file_headers

            track_changes.each do |record_params|
              file << record_params
            end
          end
        end
    end
  end
end
