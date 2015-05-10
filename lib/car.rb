Dir[File.dirname(__FILE__) + '/car/*.rb'].each { |file| require file }

class SmartCar
  def initialize(pins)
    @chassis = Car::Chassis.new(*(0..3).map { |i| Car::Wheel.new(*pins.slice(i * 4, 4)) })
  end

  def stop
    @chassis.stop
  end
end
