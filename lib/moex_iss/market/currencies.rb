# frozen_string_literal: true

module MoexIss
  module Market
    class Currencies < Collection
      def initialize(response, instance_class: MoexIss::Market::Currency)
        super
      end

      def create_instances
        @response["wap_rates"].each do |data|
          method = method_name(data)

          setup_method(method, data)
        end
      end

      private

      def method_name(data)
        data["shortname"]
          .split("_")
          .first.downcase
          .insert(3, "_")
          .to_sym
      end
    end
  end
end
