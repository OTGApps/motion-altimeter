class CMAltimeter
  def self.isRelativeAltitudeAvailable
    true
  end

  def startRelativeAltitudeUpdatesToQueue(queue, withHandler:handler)

  end

  def stopRelativeAltitudeUpdates

  end
end

class CMAltimeterUnavailable < CMAltimeter
  def self.isRelativeAltitudeAvailable
    false
  end
end


describe "motion-altimeter" do
  before do
    @ma = Motion::Altimeter.new
  end

  it "has an instance of CMAltimeter" do
    @ma.altimeter.is_a?(CMAltimeter).should == true
  end

  it "checks to see if the altitude is available." do
    CMAltimeter.isRelativeAltitudeAvailable.should == true
    CMAltimeterUnavailable.isRelativeAltitudeAvailable.should == false
  end

  # it "throws an error when trying to start and CMAltimeter is not available" do
  # end

  it "starts monitoring altitude updates" do
    @ma.is_updating?.should == false
    @ma.start {|altitude_data| }
    @ma.is_updating?.should == true
  end

  it "stops altitude updates" do
    @ma.is_updating?.should == false
    @ma.start {|altitude_data| }
    @ma.is_updating?.should == true
    @ma.stop
    @ma.is_updating?.should == false
  end

  # it "gets altitude data once" do
  #   @count = 0
  #   @ma.once do |altitude_data|
  #     @count += 1
  #   end

  #   @count.should == 1
  # end
end
