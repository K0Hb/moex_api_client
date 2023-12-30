# frozen_string_literal: true

module MoexIss
  module Market
    class Stocks
      include Enumerable

      attr_reader :response

      def initialize(response)
        @response = response
        @stocks_map = {}

        create_instances_stock
      end

      def create_instances_stock
        @response.each do |data|
          method = data["securities"]["SECID"].downcase.to_sym

          setup_method(method, data)
        end
      end

      def each
        @stocks_map.values.each { |stock| yield stock }
      end

      private

      def setup_method(method, data)
        @stocks_map[method] = Stock.new(data)

        self.class.send(:define_method, method) { @stocks_map[method] }
      end
    end
  end
end
