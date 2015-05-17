Dir[File.dirname(__FILE__) + '/car/*.rb'].each { |file| require file }

class SmartCar
  def initialize(pins, frequency)
    @chassis = Car::Chassis.new(*pins.map { |wheel_pins| Car::Wheel.new(*wheel_pins, frequency) })

    @delegation = Hash[
      [
        [@chassis, [:stop, :drive]]
      ].map { |delegator_methods|
        delegator, methods = delegator_methods
        methods.map { |method| [method, delegator] }
      }.flatten(1)
    ]
  end

  def method_missing(method, *args)
    delegator = @delegation[method]
    if delegator
      delegator.send(method, *args)
    else
      super
    end
  end
end
