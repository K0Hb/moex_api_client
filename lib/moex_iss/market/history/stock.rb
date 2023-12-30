# frozen_string_literal: true

module MoexIss
  module Market
    module History
      class Stock
        METHODS = {
          "TRADEDATE" => :trade_date, "SHORTNAME" => :short_name, "SECID" => :secid, "VALUE" => :value,
          "OPEN" => :open, "LOW" => :low, "HIGH" => :high, "LEGALCLOSEPRICE" => :legal_close_price,
          "VOLUME" => :volume
        }.freeze

        attr_reader(:response, *METHODS.values)

        def initialize(response)
          @response = response

          setup_instance_varibales(@response["history"])
        end

        private

        def setup_instance_varibales(data)
          return if data.nil?

          data.each do |key, value|
            next unless METHODS.has_key?(key)

            instance_variable_set("@#{METHODS[key]}", value)
          end
        end
      end
    end
  end
end
