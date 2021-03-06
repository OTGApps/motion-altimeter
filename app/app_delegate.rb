class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    if CMAltimeter.isRelativeAltitudeAvailable
      ma = Motion::Altimeter.new
      ma.start do |result|
        NSLog("%@", result[:relative_altitude])
      end
    else
      puts "Please run this app on a device that has a barometer."
    end

    true
  end
end
