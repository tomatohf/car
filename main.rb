#!/usr/bin/env ruby

require './lib/car'

Wiring = [
  [2, 3, 7, 0],
  [6, 5, 1, 4],
  [24, 25, 22, 23],
  [29, 28, 26, 27]
]

car = SmartCar.new(
  Wiring.map { |pins| pins.slice(0, 3) },
  20
)
