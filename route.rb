# encoding utf-8

require_relative 'instance_counter'
require_relative 'validation'
# creating class Route

class Route
  include InstanceCounter
  include Validation
  validate :station_start, :presence
  validate :station_end, :presence
  attr_accessor :stations
  attr_writer :station

  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
    @station_start = station_start
    @station_end = station_end
    valid?
  end

  def add_station(station)
    @stations << station
    @stations[-1], @stations[-2] = @stations[-2], @stations[-1]
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
# Test
  route = Route.new('Minsk','Moscow')
  puts route.valid?
  route = Route.new('','Moscow')
  route = Route.new('Minsk','')


