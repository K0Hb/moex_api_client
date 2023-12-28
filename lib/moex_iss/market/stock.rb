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

        @response["securities"].merge(@response["marketdata"]).each do |key, value|
          next unless METHODS.has_key?(key)

          instance_variable_set("@#{METHODS[key]}", value)
        end

        @market_data = @response["marketdata"].slice(*MARKET_DATA)
      end
    end
  end
end
