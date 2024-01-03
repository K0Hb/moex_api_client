# frozen_string_literal: true

module MoexIss
  class Client
    include MoexIss::Request
    include MoexIss::Hendler

    STOCKS_ENDPOINT = "engines/stock/markets/shares/boards/tqbr/securities"
    CURRENCIES_ENDPOINT = "statistics/engines/currency/markets/selt/rates"
    STANDARD_PARAMS = {
      "iss.json" => "extended",
      "iss.meta" => "off"
    }

    def stocks
      endpoint = "#{STOCKS_ENDPOINT}.json"
      params = STANDARD_PARAMS
      params["iss.only"] = "securities,marketdata"

      raw_response = get(endpoint, params)

      MoexIss::Market::Stocks.new(handle_response(raw_response))
    end

    def stock(isin, from: nil, till: nil)
      return historical_data_of_the_stock(isin, from, till) if from || till

      endpoint = "#{STOCKS_ENDPOINT}/#{isin}.json"
      params = STANDARD_PARAMS
      params["iss.only"] = "securities,marketdata"

      raw_response = get(endpoint, params)

      MoexIss::Market::Stock.new(handle_response(raw_response))
    end

    def currencies
      endpoint = "#{CURRENCIES_ENDPOINT}.json"
      params = STANDARD_PARAMS
      params["iss.only"] = "wap_rates"

      raw_response = get(endpoint, params)

      MoexIss::Market::Currencies.new(handle_response(raw_response))
    end

    private

    def historical_data_of_the_stock(isin, from, till)
      validate_date(from, till) if from || till

      endpoint = "history/#{STOCKS_ENDPOINT}/#{isin}.json"
      params = STANDARD_PARAMS.merge({from: from, till: till})

      raw_response = get(endpoint, params)

      MoexIss::Market::History::Stocks.new(handle_response(raw_response))
    end

    def validate_date(*dates)
      error = Error::InvalidDateError
      message = "Невалидная дата"

      dates.compact.each { |date| date.match?(/^\d{4}-\d{2}-\d{2}$/) ? nil : fail(error, message) }
    end
  end
end
