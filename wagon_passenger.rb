# encoding utf-8
require_relative 'wagon'

# class WagonPassenger create wagon type passenger
class WagonPassenger < Wagon
  attr_reader :type

  def initialize(number, volume)
    @type = 'passenger'
    super
  end

  def load_wagon(qount)
    qount = 1
    super
  end
end
