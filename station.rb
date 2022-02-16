# encoding utf-8

require_relative 'instance_counter'
require_relative 'validation'

# creat class Station
class Station
  include Validation
  include InstanceCounter
  attr_reader :trains_station, :name, :stations_name
  attr_writer :train
  PATTERN = /^([А-Я])([а-я]){1,}/
  validate :station_name, :presence
  validate :station_name, :format, PATTERN
  @@stations = []
  def trains_each(block)
    @trains_station.each do |train|
      block.call(train)
    end
  end

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @@stations << name
    @station_name = name
    valid?
  end

  def trains
    trains_station.count
  end

  def arrive_train(train)
    @trains_station << train
  end

  def gone_train(train)
    @trains.delete(train)
  end
end
#Test
station = Station.new('Москва')
puts station.valid?
station = Station.new('')
station = Station.new('Moscow')

