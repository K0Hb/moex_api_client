# frozen_string_literal: true

module MoexIss
  module Market
    class Stock
      METHODS = {
        "BID" => :bid, "MARKETPRICETODAY" => :market_price_today,
        "MARKETPRICE" => :market_price, "SECID" => :secid,
        "SHORTNAME" => :short_name, "LATNAME" => :lat_name,
        "BOARDID" => :board_id, "BOARDNAME" => :board_name,
        "ISIN" => :isin, "PREVPRICE" => :prev_price,
        "PREVDATE" => :prev_date
      }.freeze

      MARKET_DATA = %w[CLOSEPRICE OPEN LOW HIGH LAST VALUE SYSTIME]

      attr_reader(:response, :market_data, *METHODS.values)

      def initialize(response)
        @response = response.is_a?(Array) ? response.first : response

        setup_instance_varibales(@response["securities"])
        setup_instance_varibales(@response["marketdata"])
        setup_instance_varibales(@response["history"])

        @market_data = @response["marketdata"]&.slice(*MARKET_DATA)
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
