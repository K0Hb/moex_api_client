# frozen_string_literal: true

module MoexIss
  module Market
    class Collection
      include Enumerable

      attr_reader :response

      def initialize(response, instance_class: Security)
        @response = response
        @instance_class = instance_class
        @stocks_map = {}

        create_instances
      end

      def create_instances
        @response.each do |data|
          method = method_name(data)

          setup_method(method, data)
        end
      end

      def each
        @stocks_map.values.each { |stock| yield stock }
      end

      private

      def method_name(data)
        :some_name
      end

      def setup_method(method, data)
        @stocks_map[method] = @instance_class.new(data)

        self.class.send(:define_method, method) { @stocks_map[method] }
      end
    end
  end
end
