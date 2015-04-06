class Motion
  class Altimeter
    def initialize
      @_altimeter = CMAltimeter.alloc.init
      @_is_updating = false
    end

    def once(&block)
      @once = true
      start &block
    end

    def start(&block)
      # Check if altimeter feature is available
      if CMAltimeter.isRelativeAltitudeAvailable
        # Start altimeter updates, add it to the main queue
        @_is_updating = true
        @_altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: -> altitude_data, error {
          data = {
            relative_altitude: altitude_data.relativeAltitude.floatValue, # Relative altitude in meters
            pressure:          altitude_data.pressure.floatValue,         # Pressure in kilopascals
            error:             error
          }

          unless error.nil?
            stop if @_is_updating
            NSLog error.localizedDescription
          end

          block.call(data)

          if @once == true
            stop if @_is_updating
            @once = nil
          end
        })

      else
        NSLog "Error: Barometer not available on this device."
      end
    end

    def stop
      @_altimeter.stopRelativeAltitudeUpdates # Stop updates
      @_is_updating = false

      NSLog "Stopped relative altitude updates."
    end

    def altimeter
      @_altimeter
    end

    def is_updating?
      @_is_updating
    end
  end
end

