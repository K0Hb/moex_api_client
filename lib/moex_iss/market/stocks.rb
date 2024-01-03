# frozen_string_literal: true

module MoexIss
  module Market
    class Stocks < Collection
      def initialize(response, instance_class: MoexIss::Market::Stock)
        super
      end

      private

      def method_name(data)
        data["securities"]["SECID"].downcase.to_sym
      end
    end
  end
end
