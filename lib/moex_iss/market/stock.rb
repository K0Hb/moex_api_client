# frozen_string_literal: true

module MoexIss
  module Market
    class Stock < Security
      METHODS = {
        "BID" => :bid, "MARKETPRICETODAY" => :market_price_today,
        "MARKETPRICE" => :market_price, "SECID" => :secid,
        "SHORTNAME" => :short_name, "LATNAME" => :lat_name,
        "BOARDID" => :board_id, "BOARDNAME" => :board_name,
        "ISIN" => :isin, "PREVPRICE" => :prev_price,
        "PREVDATE" => :prev_date, "CLOSEPRICE" => :close_price,
        "OPEN" => :open, "LOW" => :low, "HIGH" => :high,
        "LAST" => :last, "VALUE" => :value, "SYSTIME" => :systime
      }.freeze

      def initialize(response)
        @response = response.is_a?(Array) ? response.first : response

        setup_methods(@response["securities"])
        setup_methods(@response["marketdata"])
        setup_methods(@response["history"])
      end
    end
  end
end
