# frozen_string_literal: true

module MoexIss
  module Market
    class Security
      attr_reader :response

      def initialize(response)
        @response = response

        setup_methods(response)
      end

      private

      def setup_methods(data)
        return if data.nil?

        data.each do |key, value|
          next unless self.class::METHODS.has_key?(key)

          define_singleton_method self.class::METHODS[key] do
            value
          end
        end
      end
    end
  end
end
