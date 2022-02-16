# encoding utf-8

require_relative 'manufacturer_name'

# create Wagon
class Wagon
  include ManufacturerName
  attr_accessor :number, :volume, :volume_busy, :volume_free
  def initialize(number, volume)
    @volume_free = volume
    @volume_busy = 0
    @number = number
  end

  def load_wagon(qount)
    @volume_busy += qount && @volume_free -= qount if @volume_free >= qount
  end
end
