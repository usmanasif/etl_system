require 'csv'

module Mapping
  POSSIBLE_CSV_DEFINITIONS = {
    csv_mapping_1: %w(services.csv clients.csv appointments.csv)
  }.with_indifferent_access

  class Base
    class << self
      def call!
        raise 'Not Implemented!'
      end
    end
  end
end
