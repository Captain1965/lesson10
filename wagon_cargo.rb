# encoding utf-8

require_relative 'wagon'

# create WagonCargo type cargo
class WagonCargo < Wagon
  attr_reader :type

  def initialize(number, volume)
    @type = 'cargo'
    super
  end
end
