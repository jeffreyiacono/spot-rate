# Spot::Rate

Get current currency spot rates

## Installation

Add this line to your application's Gemfile:

    gem 'spot-rate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spot-rate

## Usage

A SpotRate instance will by default use the GoogleCurrencyConverter if no other
currency converters are registered:

```ruby
require 'spot-rate'

puts Time.now
# => 2013-05-01 18:34:09 -0700
puts SpotRate.new(:from_currency => 'USD', :to_currency => 'CAD').spot_rate
# => 1.01689986

# or, more concisely:
puts SpotRate['USD' => 'CAD']
# => 1.01689986
```

If you'd like to register your own currency converter, use the
`.register_currency_converter` method:

```ruby
require 'spot-rate'

class MyRandomCurrencyConverter
  def initialize from_currency, to_currency
    @from_currency = from_currency
    @to_currency   = to_currency
  end

  def spot_rate
    rand # yolo
  end
end

SpotRate.register_currency_converter(:random_converter, MyRandomCurrencyConverter)
spot_rate = SpotRate.new(:from_currency => 'USD', :to_currency => 'CAD')
puts spot_rate.use(:random_converter).spot_rate
# => 0.5363022464905228
puts spot_rate.spot_rate # will go back to using the pre-packaged default Google converter
# => 1.01689986
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Jeff Iacono

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
