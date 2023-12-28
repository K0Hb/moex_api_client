# frozen_string_literal: true

module MoexIss
  class Client
    include MoexIss::Request
    include MoexIss::Hendler

    STOCKS_ENDPOINT = "engines/stock/markets/shares/boards/tqbr/securities"
    STANDARD_PARAMS = {
      "iss.json" => "extended",
      "iss.only" => "securities,marketdata",
      "iss.meta" => "off"
    }

    def stocks
      endpoint = "#{STOCKS_ENDPOINT}.json"
      params = STANDARD_PARAMS

      raw_response = get(endpoint, params)

      MoexIss::Market::Stocks.new(handle_response(raw_response))
    end

    def stock(isin)
      endpoint = "#{STOCKS_ENDPOINT}/#{isin}.json"
      params = STANDARD_PARAMS

      raw_response = get(endpoint, params)

      MoexIss::Market::Stock.new(handle_response(raw_response))
    end
  end
end
