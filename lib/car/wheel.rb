require 'wiringpi'

module Car
  class Wheel
    def initialize(pin1, pin2, pwm, frequency)
      @pin1 = pin1
      @pin2 = pin2
      @pwm = pwm
      @range = (1000000 / 100 / frequency).round

      @gpio = WiringPi::GPIO.new
      each_pin { |pin| @gpio.pin_mode(pin, WiringPi::OUTPUT) }
      @gpio.soft_pwm_create(@pwm, 0, @range)
    end

    def stop
      @gpio.soft_pwm_write(@pwm, 0)
      each_pin { |pin| @gpio.digital_write(pin, WiringPi::LOW) }
    end

    def speed=(value)
      if (value == 0)
        stop
      else
        @gpio.soft_pwm_write(@pwm, [value.abs, 1].min * @range)

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
