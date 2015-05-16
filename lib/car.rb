Dir[File.dirname(__FILE__) + '/car/*.rb'].each { |file| require file }

class SmartCar
  def initialize(pins, frequency)
    @chassis = Car::Chassis.new(*pins.map { |wheel_pins| Car::Wheel.new(*wheel_pins, frequency) })
  end

  def stop
    @chassis.stop
  end
end
