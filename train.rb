# encoding utf-8

require_relative 'manufacturer_name'
require_relative 'instance_counter'
require_relative 'validation.rb'

class Train
  include InstanceCounter
  include ManufacturerName
  include Validation
  attr_accessor :number, :route, :wagons, :wagon, :trains
  attr_reader :curent_speed, :curent_station_index
  PATTERN = /^([а-я0-9])([а-я0-9])([а-я0-9])(-|)([а-я0-9])([а-я0-9])/i
  validate :train_number, :presence
  validate :train_number, :format, PATTERN
  validate :train_number, :type, String

  def self.find(train_number)
    @@trains.find { |train| train.number == train_number }
  end

  def wagon_each(block)
    @wagons.each do |wagon|
      block.call(wagon)
    end
  end

  def initialize(number)
    @train_name = number.to_s
    @@trains = []
    @number = number
    @curent_speed = 0
    @route = []
    @wagons = []
    @train_number = number
    valid?
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def delete_wagon
    @wagons.delete_at(-1) unless @wagons.empty?
  end

  def speed(value)
    @curent_speed += value
  end

  def stop
    @curent_speed = 0
  end

  def add_route
    @curent_station_index = 0
  end

  def departure
    @curent_station_index += 1 if @curent_station_index < @route.stations.size - 1
  end

  def arrival
    @curent_station_index -= 1 if @curent_station_index >= 1
  end
end

  #Test
  train = Train.new('12345')
  puts train.valid?
  train = Train.new('')
  train = Train.new(1456)




