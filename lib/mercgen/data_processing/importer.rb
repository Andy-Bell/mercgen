require 'smarter_csv'

module Mercgen
  module DataProcessing
    class Importer
      attr_accessor :data

      def initialize(path)
        @data = SmarterCSV.process(path, col_sep: "\t", duplicate_header_suffix: "dup")
      end
    end
  end
end
