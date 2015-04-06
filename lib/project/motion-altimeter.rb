class Motion
  class Altimeter
    def initialize
      @altimeter = CMAltimeter.alloc.init
    end

    def start(&block)
      # Check if altimeter feature is available
      if CMAltimeter.isRelativeAltitudeAvailable
        # Start altimeter updates, add it to the main queue
        @altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: -> altitude_data, error {
          data = {
            relative_altitude: altitude_data.relativeAltitude.floatValue, # Relative altitude in meters
            pressure:          altitude_data.pressure.floatValue,         # Pressure in kilopascals
            error:             error
          }

          unless error.nil?
            stop
            NSLog error.localizedDescription
          end

          block.call(data)
        })

      else
        NSLog "Error: Barometer not available on this device."
      end
    end

    def stop
      @altimeter.stopRelativeAltitudeUpdates # Stop updates

      NSLog "Stopped relative altitude updates."
    end
  end
end

