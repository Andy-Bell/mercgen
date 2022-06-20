module Mercgen
  module DataProcessing
    class Filterer
      attr_accessor :data

      def initialize(data)
        @data = data
      end

      def keep_if_true(key, value)
        data.filter{ |d| !d[key].nil? && d[key] == value }
      end

      def keep_if_greater(key, value)
        data.filter{ |d| !d[key].nil? && d[key] >= value }
      end

      def hard_remove_if_true(key, value)
        data.delete_if{ |d| !d[key].nil? && d[key] == value }
      end

      def hard_remove_if_present (key)
        data.delete_if{ |d| !d[key].nil? }
      end

      def remove_if_true(key, value)
        data.reject{|d| !d[key].nil? && d[key] == value }
      end
    end
  end
end
