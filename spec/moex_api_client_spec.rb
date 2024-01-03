# frozen_string_literal: true

RSpec.describe MoexIss do
  subject { MoexIss.client }

  context "errors" do
    context "ResponseSchemaError" do
      let(:error) { MoexIss::Error::ResponseSchemaError }
      let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/invalid_response.js") }

      before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}.json.*/).to_return(status: 200, body: body) }

      it { expect { subject.stocks }.to raise_error(error) }
    end

    context "ResponseParseError" do
      let(:error) { MoexIss::Error::ResponseParseError }

      before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}.json.*/).to_return(status: 200, body: "Invalid Json") }

      it { expect { subject.stocks }.to raise_error(error) }
    end

    MoexIss::Error::ERRORS.each do |status, error|
      context error do
        before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}.json.*/).to_return(status: status, body: "Some Error") }

        it { expect { subject.stocks }.to raise_error(error) }
      end
    end
  end

  context "stocks" do
    let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/stocks.js") }
    let(:stocks) { subject.stocks }

    before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}.json.*/).to_return(status: 200, body: body) }

    it { expect(stocks).to be_a MoexIss::Market::Stocks }
    it { expect(stocks.response).to be_a Array }
    it { expect(stocks.response).to include({"securities" => Hash, "marketdata" => Hash}) }
    it { expect(stocks.count).to eq(4) }
    it { expect(stocks.methods).to include(:yndx, :astr, :kmaz, :sber) }
    it { expect(stocks.yndx).to be_a MoexIss::Market::Stock }
    it { expect(stocks.yndx.short_name).to eq("Yandex clA") }
  end

  context "stock" do
    let(:iss) { :sber }
    let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/stock.js") }
    let(:stock) { subject.stock(iss) }

    before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}\/#{iss}.json.*/).to_return(status: 200, body: body) }

    it { expect(stock).to be_a MoexIss::Market::Stock }
    it { expect(stock.response).to be_a Hash }
    it { expect(stock.response).to include({"securities" => Hash, "marketdata" => Hash}) }
    it { expect(stock.bid).to eq 271.86 }
    it { expect(stock.market_price_today).to eq 270.3 }
    it { expect(stock.market_price).to eq 271.37 }
    it { expect(stock.secid).to eq "SBER" }
    it { expect(stock.short_name).to eq "Сбербанк" }
    it { expect(stock.lat_name).to eq "Sberbank" }
    it { expect(stock.board_id).to eq "TQBR" }
    it { expect(stock.board_name).to eq "Т+: Акции и ДР - безадрес." }
    it { expect(stock.isin).to eq "RU0009029540" }
    it { expect(stock.prev_price).to eq 271.9 }
    it { expect(stock.prev_date).to eq "2023-12-26" }
    it { expect(stock.close_price).to be_nil }
    it { expect(stock.high).to eq 272.59 }
    it { expect(stock.low).to eq 271.05 }
    it { expect(stock.open).to eq 271.9 }
    it { expect(stock.last).to eq 271.88 }
    it { expect(stock.value).to eq 5437.6 }

    context "historical_data_of_the_stock" do
      let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/history_stock.js") }
      let(:from) { "2023-12-27" }
      let(:till) { "2023-12-29" }
      let(:history_stocks) { subject.stock(iss, from: from, till: till) }

      before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/history\/#{MoexIss::Client::STOCKS_ENDPOINT}\/#{iss}.json.*/).to_return(status: 200, body: body) }

      it { expect(history_stocks).to be_a MoexIss::Market::History::Stocks }
      it { expect(history_stocks.response).to be_a Hash }
      it { expect(history_stocks.response).to include("history" => Array) }
      it { expect(history_stocks.count).to eq 3 }
      it { expect(history_stocks[from]).to be_a MoexIss::Market::History::Stock }
      it { expect(history_stocks[from]).to eq history_stocks.first }

      context "history_stock" do
        let(:history_stock) { subject.stock(iss, from: from, till: till)[from] }

        it { expect(history_stock).to be_a MoexIss::Market::History::Stock }
        it { expect(history_stock.response).to be_a Hash }
        it { expect(history_stock.secid).to eq "SBER" }
        it { expect(history_stock.short_name).to eq "Сбербанк" }
        it { expect(history_stock.trade_date).to eq "2023-12-27" }
        it { expect(history_stock.open).to eq 271.9 }
        it { expect(history_stock.legal_close_price).to eq 271.55 }
        it { expect(history_stock.high).to eq 272.59 }
        it { expect(history_stock.low).to eq 270.85 }
        it { expect(history_stock.volume).to eq 17214050 }
        it { expect(history_stock.value).to eq 4676446141.7 }
      end
    end
  end

  context "currencies" do
    let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/currencies.js") }
    let(:currencies) { subject.currencies }

    before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::CURRENCIES_ENDPOINT}.json.*/).to_return(status: 200, body: body) }

    it { expect(currencies).to be_a MoexIss::Market::Currencies }
    it { expect(currencies.response).to be_a Hash }
    it { expect(currencies.response).to include({"wap_rates" => Array}) }
    it { expect(currencies.count).to eq(3) }
    it { expect(currencies.methods).to include(:usd_rub, :eur_rub, :cny_rub) }
    it { expect(currencies.usd_rub).to be_a MoexIss::Market::Currency }
    it { expect(currencies.usd_rub.short_name).to eq("USDRUB_TOM") }

    context "currency" do
      let(:currency) { subject.currencies.cny_rub }

      it { expect(currency).to be_a MoexIss::Market::Currency }
      it { expect(currency.response).to be_a Hash }
      it { expect(currency.trade_date).to eq "2023-12-29" }
      it { expect(currency.trade_time).to eq "15:29:54" }
      it { expect(currency.price).to eq 12.5762 }
      it { expect(currency.secid).to eq "CNYRUB_TOM" }
      it { expect(currency.short_name).to eq "CNYRUB_TOM" }
      it { expect(currency.last_top_rev_price).to eq 0.0987 * -1 }
      it { expect(currency.nominal).to eq 1 }
      it { expect(currency.decimals).to eq 4 }
    end
  end
end
