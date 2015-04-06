# motion-altimeter

Block-based RubyMotion gem for interacting with the [CMAltimeter](https://developer.apple.com/library/prerelease/ios/documentation/CoreMotion/Reference/CMAltimeter_class/index.html) class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'motion-altimeter'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install motion-altimeter
```

## Usage

It's fairly easy to get altitude data using `motion-altimeter`:

```ruby
# Create your `Motion::Altimeter` object
my_altimeter = Motion::Altimeter.new

# Start getting updates
if CMAltimeter.isRelativeAltitudeAvailable
  my_altimeter.start do |altitude|
    # Do something with the altitude data.
    #
    # altitude is a hash with the following properties:
    # {
    #    relative_altitude: 0.0,
    #    pressure: 0.0,
    #    error: nil
    # }
    # See Apple docs for CMAltitudeData to see what each of these is
  end
else
  puts "This device doesn't have a barometer to support relative altitudes."
end

# Somewhere else: stop getting updates
my_altimeter.stop
```

If the device doesn't support CMAltimeter, it will not start. You should check
before starting updates with a check to `CMAltimeter.isRelativeAltitudeAvailable`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
