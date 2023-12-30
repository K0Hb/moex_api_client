# frozen_string_literal: true

module MoexIss
  module Connection
    BASE_URL = "https://iss.moex.com/iss"

    module DoNotEncoder
      def self.encode(params)
        params.map { |k, v| "#{k}=#{v}" }.join("&")
      end
    end

    def connection
      Faraday.new(options) do |con|
        con.adapter Faraday.default_adapter
        con.request :url_encoded
        con.options.params_encoder = DoNotEncoder
      end
    end

    private

    def options
      headers = {
        accept: "application/json",
        content_type: "application/x-www-from-urlencoded",
        user_agent: "moex_iss gem"
      }

      {
        headers: headers,
        url: BASE_URL
      }
    end
  end
end

# CURENCY    https://iss.moex.com/iss/statistics/engines/currency/markets/selt/rates.json?iss.meta=off&iss.json=extended&iss.only=wap_rates
