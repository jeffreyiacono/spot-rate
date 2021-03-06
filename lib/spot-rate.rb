require 'spot_rate/version'

class SpotRate
  class CurrencyNotFound < RuntimeError; end

  attr_accessor :from_currency, :to_currency

  def self.available_converters
    @@available_converters ||= {}
  end

  def self.register_currency_converter converter_key, converter_class
    self.available_converters[converter_key.to_sym] = converter_class
  end

  def self.[] hash
    raise ArgumentError unless hash.size <= 2

    new(from_currency: hash.keys.first, to_currency: hash.values.first)
      .use(hash[:use] || hash[:using] || :default)
      .spot_rate
  end

  def initialize config = {}
    @from_currency = config[:from_currency]
    @to_currency   = config[:to_currency]
  end

  def use requested_converter_key
    self.class
        .available_converters[requested_converter_key.to_sym]
        .new @from_currency, @to_currency
  end

  def spot_rate
    default_currency_converter.spot_rate
  end

  def default_currency_converter
    use :default
  end
end

require 'spot_rate/google_currency_converter'
SpotRate.register_currency_converter :default, SpotRate::GoogleCurrencyConverter
