# frozen_string_literal: true

module MoexIss
  module Market
    class Stocks < Collection
      def initialize(response, instance_class: MoexIss::Market::Stock)
        super
      end

      def create_instances_stock
        @response.each do |data|
          method = method_name(data)

          setup_method(method, data)
        end
      end

      private

      def method_name(data)
        data["securities"]["SECID"].downcase.to_sym
      end
    end
  end
end
