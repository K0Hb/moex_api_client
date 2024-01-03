# frozen_string_literal: true

module MoexIss
  module Market
    class Currency
      METHODS = {
        "tradedate" => :trade_date, "tradetime" => :trade_time,
        "secid" => :secid, "shortname" => :short_name,
        "price" => :price, "lasttoprevprice" => :last_top_rev_price,
        "nominal" => :nominal, "decimals" => :decimals
      }.freeze

      attr_reader(:response, *METHODS.values)

      def initialize(response)
        @response = response

        setup_instance_varibales(@response)
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
