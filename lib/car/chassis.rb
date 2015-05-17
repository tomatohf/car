module Car
  class Chassis
    def initialize(wheel_lf, wheel_rf, wheel_lr, wheel_rr)
      @wheel_left_front = wheel_lf
      @wheel_right_front = wheel_rf
      @wheel_left_rear = wheel_lr
      @wheel_right_rear = wheel_rr
    end

    def stop
      wheels.each { |wheel| wheel.stop }
    end

    def drive(speed)
      wheels.each { |wheel| wheel.speed = speed }
    end

    def left_wheels
      [@wheel_left_front, @wheel_left_rear]
    end

    def right_wheels
      [@wheel_right_front, @wheel_right_rear]
    end

    def wheels
      left_wheels + right_wheels
    end
  end
end
