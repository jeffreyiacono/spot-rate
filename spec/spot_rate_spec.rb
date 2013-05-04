require './lib/spot-rate'

class SomeCurrencyConverter
  def initialize from, to
    @from = from
    @to   = to
  end

  def spot_rate
    "#{@from} #{@to}"
  end
end

describe SpotRate do
  describe "[]" do
    it "returns the requested spot rate using the requested converter" do
      SpotRate.register_currency_converter :some_currency_converter, SomeCurrencyConverter
      expect(SpotRate['this' => 'that', use: :some_currency_converter]).to eq 'this that'
    end

    it "returns the requested spot rate using the default converter if nothing specified" do
      stub_converter = stub(:spot_rate => 'this that')
      SpotRate::GoogleCurrencyConverter.stub(:new).and_return(stub_converter)
      expect(SpotRate['this' => 'that']).to eq 'this that'
    end
  end

  describe ".register_currency_converter" do
    it "adds the converter to the list of available currency converters" do
      expect(SpotRate.available_converters).to_not include SomeCurrencyConverter
      SpotRate.register_currency_converter :some_currency_converter, SomeCurrencyConverter
      expect(SpotRate.available_converters[:some_currency_converter]).to eq SomeCurrencyConverter
    end
  end

  describe "#default_currency_converter" do
    it "is an instance of the Google Currency Converter" do
      spot_rate = SpotRate.new
      expect(spot_rate.default_currency_converter).to be_a SpotRate::GoogleCurrencyConverter
    end
  end

  describe "#use" do
    it "returns the spot rate as determined by the requested converter" do
      SpotRate.register_currency_converter :some_currency_converter, SomeCurrencyConverter
      spot_rate = SpotRate.new(from_currency: 'something', to_currency: 'another thing')
      expect(spot_rate.use(:some_currency_converter).spot_rate).to eq "something another thing"
    end
  end

  describe "#spot_rate" do
    it "returns the spot rate as determined by the default converter" do
      SpotRate.register_currency_converter :default, SomeCurrencyConverter
      spot_rate = SpotRate.new(from_currency: 'something', to_currency: 'another thing')
      expect(spot_rate.spot_rate).to eq "something another thing"
    end
  end
end
