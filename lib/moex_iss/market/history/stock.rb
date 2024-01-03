# frozen_string_literal: true

module MoexIss
  module Market
    module History
      class Stock < Security
        METHODS = {
          "TRADEDATE" => :trade_date, "SHORTNAME" => :short_name, "SECID" => :secid, "VALUE" => :value,
          "OPEN" => :open, "LOW" => :low, "HIGH" => :high, "LEGALCLOSEPRICE" => :legal_close_price,
          "VOLUME" => :volume
        }.freeze

        def initialize(response)
          setup_methods(response["history"])

          super
        end
      end
    end
  end
end
