#86 LOC using Enumerable
require 'csv'
class Sample

  attr_accessor :x, :y
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

  def calculate_b1(samples)
    n = samples.size

    data_x = samples.collect{ |i| i.x }
    data_y = samples.collect{ |i| i.y }
    average_x = average( data_x )
    average_y = average( data_y )

    part_1 = summation_x_multiplied_y( samples )
    part_2 = n * average_x * average_y
    part_3 = summation_power_of_two( data_x )
    part_4 = n * ( average_x * average_x )

    b1 = (part_1 - part_2) / (part_3 - part_4)
    b1.round(@round)
  end

  def calculate_b0(b1, samples)
    average_x = average( samples.collect{ |i| i.x} )
    average_y = average( samples.collect{ |i| i.y} )

    b0 = average_y - (b1 * average_x)
    b0.round(@round)
  end

  def calculate_r(samples)
    n = samples.size

    data_x = samples.collect{ |i| i.x }
    data_y = samples.collect{ |i| i.y }
    summation_x = data_x.reduce(:+)
    summation_y = data_y.reduce(:+)

    part_1 = n * summation_x_multiplied_y( samples )
    part_2 = summation_x * summation_y
    part_3 = ( n * summation_power_of_two( data_x ) ) - ( summation_x**2 )
    part_4 = ( n * summation_power_of_two( data_y ) ) - ( summation_y**2 )

    r = (part_1 - part_2) / Math.sqrt( part_3 * part_4)
    r.round(@round)
  end

  def calcuate_r_power_two(r)
    r2 = r * r
    r2.round(@round)
  end

  def calculate_prediction(b0, b1)
    p = b0 + b1 * E
    p.round(@round)
  end

  def average(data)
    data.reduce(:+) / data.count
  end

  def summation_x_multiplied_y(samples)
    samples.inject(0){ |sum, sample| (sample.x * sample.y) + sum }
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

stats = Stats.new(4)
b1 = stats.calculate_b1(samples)
b0 = stats.calculate_b0(b1, samples)
r = stats.calculate_r(samples)
r2 = stats.calcuate_r_power_two(r)
p = stats.calculate_prediction(b0, b1)

puts "Test #{filename}> b0: #{b0}, b1: #{b1}, r: #{r}, r2: #{r2}, p:#{p}"








