# frozen_string_literal: true

module MoexIss
  module Market
    module History
      class Stocks < MoexIss::Market::Stocks
        def create_instances_stock
          @response["history"].each do |data|
            @stocks_map[data["TRADEDATE"]] = History::Stock.new({"history" => data})
          end
        end

        def [](key)
          @stocks_map[key]
        end
      end
    end
  end
end
