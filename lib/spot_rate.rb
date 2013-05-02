class SpotRate
  class CurrencyNotFound < RuntimeError; end

  attr_accessor :from_currency, :to_currency

  def initialize config = {}
    self.from_currency = config[:from_currency]
    self.to_currency   = config[:to_currency]
  end

  def spot_rate
    default_converter.new(self.from_currency, self.to_currency).spot_rate
  end

private

  def default_converter
    require './lib/spot_rate/goog_currency_converter'
    GoogCurrencyConverter
  end
end
