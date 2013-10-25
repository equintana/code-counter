#86 LOC using Enumerable
require 'csv'

class Sample

  attr_accessor :x, :y
  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x, y
  end

  def to_s
    puts "x:#{x}, y:#{y}"
  end
end

class Stats

  E = 386

  attr_accessor :round
  
  def initialize(round)
    @round = round
  end

 def calculate_b1(data_x, data_y)
    n = data_x.count
    average_x = average( data_x )
    average_y = average( data_y )

    quotient = summation_x_multiplied_y( data_x, data_y ) - ( n * average_x * average_y )
    divider = summation_power_of_two( data_x ) - ( n * ( average_x * average_x ) )

    b1 = (quotient / divider)
    b1.round(@round)
  end

  def calculate_b0(b1, data_x, data_y)
    b0 = average( data_y ) - ( b1 * average( data_x ) )
    b0.round(@round)
  end

  def calculate_r(data_x, data_y)
     n = data_x.size
    summation_x = data_x.reduce(:+)
    summation_y = data_y.reduce(:+)

    quotient = n * summation_x_multiplied_y( data_x, data_y ) - ( summation_x * summation_y )
    divider_1 = ( n * summation_power_of_two( data_x ) ) - ( summation_x**2 )
    divider_2 = ( n * summation_power_of_two( data_y ) ) - ( summation_y**2 )

    r = quotient / Math.sqrt( divider_1 * divider_2)
    r.round(@round)
  end

  def calcuate_r_power_two(r)
    r2 = (r * r).round(@round)
  end

  def calculate_prediction(b0, b1)
    p = (b0 + b1 * E).round(@round)
  end

  def average(data)
    data.reduce(:+) / data.count
  end

  def summation_x_multiplied_y(data_x, data_y)
    (0...data_x.count).inject(0){ |sum_xy, i| sum_xy + data_x[i]*data_y[i] }
  end

  def summation_power_of_two(data)
    data.inject(0){ |sum_power, i| i**2 + sum_power }
  end
end

def extract_data_csv(filename)
  samples = Array.new
  CSV.foreach(filename) do |row|
    samples = samples.push(Sample.new(row[0].to_f, row[1].to_f))
  end
  samples
end

filename = ARGV.first 
samples = extract_data_csv( filename )
data_x = samples.collect{ |i| i.x }
data_y = samples.collect{ |i| i.y }

stats = Stats.new(4)
b1 = stats.calculate_b1(data_x, data_y)
b0 = stats.calculate_b0(b1, data_x, data_y)
r = stats.calculate_r(data_x, data_y)
r2 = stats.calcuate_r_power_two(r)
p = stats.calculate_prediction(b0, b1)
puts "Test #{filename}> b0: #{b0}, b1: #{b1}, r: #{r}, r2: #{r2}, p:#{p}"








