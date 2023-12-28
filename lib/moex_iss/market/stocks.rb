# frozen_string_literal: true

module MoexIss
  module Market
    class Stocks
      include Enumerable

      attr_reader :stocks_response

      def initialize(stocks_response)
        @stocks_response = stocks_response
        @stocks_map = {}

        create_instances_stock
      end

      def create_instances_stock
        @stocks_response.each do |stock_response|
          sicid = stock_response["securities"]["SECID"].downcase.to_sym

          @stocks_map[sicid] = Stock.new(stock_response)

          self.class.send(:define_method, sicid) { @stocks_map[sicid] }
        end
      end

      def each
        @stocks_map.values.each { |stock| yield stock }
      end
    end
  end
end
