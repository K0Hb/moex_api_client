# frozen_string_literal: true

module MoexIss
  module Market
    class Collection
      include Enumerable

      attr_reader :response

      def initialize(response, instance_class: Security)
        @response = response
        @instance_class = instance_class
        @collection_map = {}

        create_instances
      end

      def create_instances
        @response.each do |data|
          method = method_name(data)

          setup_method(method, data)
        end
      end

      def each
        @collection_map.values.each { |stock| yield stock }
      end

      private

      def method_name(data)
        :some_name
      end

      def setup_method(method, data)
        @collection_map[method] = @instance_class.new(data)

        self.class.send(:define_method, method) { @collection_map[method] }
      end
    end
  end
end
