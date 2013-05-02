require 'net/http'
require './lib/spot_rate/google_currency_converter'

describe SpotRate::GoogleCurrencyConverter do
  describe "#spot_rate" do
    it "returns a number (no stubbing + requires internet connection)" do
      converter = described_class.new 'USD', 'JPY'
      expect(converter.spot_rate.class).to eq Float
    end

    it "returns the spot conversion rate from the from_currency to the to_currency" do
      Net::HTTP.stub(:get).and_return('{lhs: "1 U.S. dollar",rhs: "98.222 Japanese yen",error: "",icc: true}')
      converter = described_class.new 'USD', 'JPY'
      expect(converter.spot_rate).to eq 98.222
    end

    it "handles errors when we get an error code back" do
      Net::HTTP.stub(:get).and_return('{lhs: "does not matter",rhs: "does not matter",error: "4",icc: true}')
      converter = described_class.new 'USD', 'BAD'
      expect { converter.spot_rate }.to raise_error SpotRate::CurrencyNotFound
    end
  end
end
