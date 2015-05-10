require 'wiringpi'

module Car
  class Wheel
    def initialize(pin1, pin2, pwm1, pwm2)
      @pin1 = pin1
      @pin2 = pin2

      @gpio = WiringPi::GPIO.new
      each_pin { |pin| @gpio.pin_mode(pin, WiringPi::OUTPUT) }
    end

    def stop
      each_pin { |pin| @gpio.digital_write(pin, WiringPi::LOW) }
    end

    def direction=(value)
      if (value == 0)
        stop
      else
        pin_high, pin_low = (value > 0) ? pins : pins.reverse
        @gpio.digital_write(pin_high, WiringPi::HIGH)
        @gpio.digital_write(pin_low, WiringPi::LOW)
      end
    end

    def direction
      value1, value2 = pins.map { |pin| @gpio.digital_read(pin) }
      if (value1 > value2)
        1
      elsif (value1 < value2)
        -1
      else
        0
      end
    end

    def pins
      [@pin1, @pin2]
    end

    def each_pin(&block)
      pins.each(&block)
    end
  end
end
