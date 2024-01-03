# frozen_string_literal: true

module MoexIss
  module Market
    module History
      class Stocks < MoexIss::Market::Collection
        def initialize(response, instance_class: MoexIss::Market::History::Stock)
          super
        end

        def create_instances
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
