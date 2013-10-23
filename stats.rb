#stats.rb

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

	def calculate_b1(test)
		b1 = 0
		n = test.size

		data_x = test.collect{ |i| i.x }
		data_y = test.collect{ |i| i.y }		
		average_x = average( data_x )
		average_y = average( data_y )

		part_1 = summation_x_multiplied_y( test )
		part_2 = n * average_x * average_y
		part_3 = summation_power_of_two( data_x )
		part_4 = n * ( average_x * average_x )

		b1 = (part_1 - part_2) / (part_3 - part_4)
		b1.round(@round)
	end

	def calculate_b0(b1, test)
		b0 = 0
		average_x = average(test.collect{ |i| i.x})
		average_y = average(test.collect{ |i| i.y})

    b0 = average_y - (b1 * average_x)
    b0.round(@round)
	end

	def calculate_r(test)
		r = 0
		n = test.size
		
		data_x = test.collect{ |i| i.x }
		data_y = test.collect{ |i| i.y }		

    summation_x = summation(data_x)
    summation_y = summation(data_y)

		part_1 = n * summation_x_multiplied_y( test )
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

def summation(data)
		sum = 0
		data.each do |i|
			sum += i
		end
		sum
	end

	def average(data)
		avg = summation(data) / data.size
	end

  def summation_x_multiplied_y(test)
    sum = 0
    test.each do |sample|
			sum += sample.x * sample.y 
		end
		sum
  end

  def summation_power_of_two(data)
    sum = 0
    data.each do |i|
			sum += i**2
		end
		sum
  end

end

def extract_data( x , y )
	test = Array.new
	File.open('stats.txt', 'r') do |file|  
	  while line = file.gets  
	  	data = line.lstrip.chomp.split(',')
	  	test.push(Sample.new(data[x].to_f , data[y].to_f ))
	  end
	end
	test
end


stats = Stats.new(4)

combinations = [ { "x" => 0 , "y" => 2 }, { "x" => 0 , "y" => 3 } , { "x" => 1 , "y" => 2 } , { "x" => 1 , "y" => 3 } ]
combinations.each_with_index do |c, index|
	test = extract_data(  c["x"], c["y"] )
	b1 = stats.calculate_b1(test)
	b0 = stats.calculate_b0(b1, test)
	r = stats.calculate_r(test)
	r2 = stats.calcuate_r_power_two(r)
	p = stats.calculate_prediction(b0, b1)

	puts "Test #{index+1} > b0: #{b0}, b1: #{b1}, r: #{r}, r2: #{r2}, p:#{p}"
end








