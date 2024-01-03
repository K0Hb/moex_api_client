# frozen_string_literal: true

module MoexIss
  module Market
    class Currency < Security
      METHODS = {
        "tradedate" => :trade_date, "tradetime" => :trade_time,
        "secid" => :secid, "shortname" => :short_name,
        "price" => :price, "lasttoprevprice" => :last_top_rev_price,
        "nominal" => :nominal, "decimals" => :decimals
      }.freeze
    end
  end
end
