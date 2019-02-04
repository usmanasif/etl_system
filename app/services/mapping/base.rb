require 'csv'

module Mapping
  class Base
    class << self
      def call!
        raise 'Not Implemented!'
      end
    end
  end
end
