require 'net/http'

class SpotRate
  class GoogCurrencyConverter
    GOOG_CURRENCY_URI = 'http://www.google.com/ig/calculator?hl=en&q=1%s=?%s'

    attr_accessor :from_currency, :to_currency

    def initialize from_currency, to_currency
      self.from_currency = from_currency
      self.to_currency   = to_currency
    end

    def spot_rate
      @response = Net::HTTP.get ccy_api_uri
      validate_converter_response! and pluck_spot_rate_from_converter_response
    end

  private

    def ccy_api_uri
      URI(GOOG_CURRENCY_URI % [from_currency, to_currency])
    end

    def validate_converter_response!
      if @response =~ /error: \"\d\"/
        raise SpotRate::CurrencyNotFound, <<-EOS
          one (or both) currencies not found #{from_currency}, #{to_currency}
        EOS
      end
      true
    end

    def pluck_spot_rate_from_converter_response
      @response.split('"')[3].to_f
    end
  end
end
