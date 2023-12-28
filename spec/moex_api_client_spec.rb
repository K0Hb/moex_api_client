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
    it { expect(stocks.stocks_response).to be_a Array }
    it { expect(stocks.stocks_response).to include({"securities" => Hash, "marketdata" => Hash}) }
    it { expect(stocks.count).to eq(4) }
    it { expect(stocks.methods).to include(:yndx, :astr, :kmaz, :sber) }
    it { expect(stocks.yndx).to be_a MoexIss::Market::Stock }
    it { expect(stocks.yndx.short_name).to eq("Yandex clA") }
  end

  context "stock" do
    let(:iss) { :sber }
    let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/stock.js") }
    let(:stock) { subject.stock(iss) }

    let(:market_data) { {"CLOSEPRICE" => nil, "HIGH" => 272.59, "LAST" => 271.88, "LOW" => 271.05, "OPEN" => 271.9, "SYSTIME" => "2023-12-27 16:23:59", "VALUE" => 5437.6} }

    before { stub_request(:get, /#{MoexIss::Connection::BASE_URL}\/#{MoexIss::Client::STOCKS_ENDPOINT}\/#{iss}.json.*/).to_return(status: 200, body: body) }

    it { expect(stock).to be_a MoexIss::Market::Stock }
    it { expect(stock.response).to be_a Hash }
    it { expect(stock.response).to include({"securities" => Hash, "marketdata" => Hash}) }
    it { expect(stock.bid).to eq(271.86) }
    it { expect(stock.market_price_today).to eq(270.3) }
    it { expect(stock.market_price).to eq(271.37) }
    it { expect(stock.secid).to eq("SBER") }
    it { expect(stock.short_name).to eq("Сбербанк") }
    it { expect(stock.lat_name).to eq("Sberbank") }
    it { expect(stock.board_id).to eq("TQBR") }
    it { expect(stock.board_name).to eq("Т+: Акции и ДР - безадрес.") }
    it { expect(stock.isin).to eq("RU0009029540") }
    it { expect(stock.prev_price).to eq(271.9) }
    it { expect(stock.prev_date).to eq("2023-12-26") }
    it { expect(stock.market_data).to eq(market_data) }
  end
end
