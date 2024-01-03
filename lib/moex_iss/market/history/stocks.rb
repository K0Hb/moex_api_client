# frozen_string_literal: true

module MoexIss
  module Market
    module History
      class Stocks < Collection
        def initialize(response, instance_class: MoexIss::Market::History::Stock)
          super
        end

        def create_instances
          @response["history"].each do |data|
            @collection_map[data["TRADEDATE"]] = @instance_class.new({"history" => data})
          end
        end

        def [](key)
          @collection_map[key]
        end
      end
    end
  end
end
