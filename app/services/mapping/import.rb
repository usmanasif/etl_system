module Mapping
  class Import < Base
    class << self
      attr_accessor :folder_name, :filename, :changes_are_made, :file_headers, :track_failures

      def call!(directory, mapping_definition=:csv_mapping_1)
        @folder_name = directory

        POSSIBLE_CSV_DEFINITIONS[mapping_definition].each do |filename|
          @filename = filename
          @track_failures = []

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
          klass = file_basename.singularize.capitalize

          "Entities::#{klass}".constantize
        end

        def import_file
          entity_class = get_entity_class
          file_path = File.join(folder_name, filename)

          CSV.read(file_path, headers: true).each do |row| @file_headers ||= row.headers
            response = entity_class.import(row.to_h)

            if response[:status] == :success
              @changes_are_made ||= true
            else
              track_failures << row.fields + [response[:message]]
            end
          end
        end

        def generate_report
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

            file << file_headers + ['Error'] unless changes_are_made

            track_failures.each do |record_params|
              file << record_params
            end
          end
        end
    end
  end
end
