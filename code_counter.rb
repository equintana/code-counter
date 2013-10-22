# code_counter.rb
=begin
   Ignore: 
   1. In-line comments 
   2. Empty line
   3. Block comments
=end

def is_a_in_line_comment(line)
  return line.start_with?("#")  
end

def is_a_empty_line(line)
  return line.empty?
end

def is_line_of_code(line)
  if is_a_in_line_comment(line)
    return false
  end
  if is_a_empty_line(line)
    return false
  end
  return true
end

def count_lines(file_to_read)
  lines_of_code = 0
  the_file = file_to_read ? file_to_read: $0
  File.open(the_file, 'r') do |f1|  
    while line = f1.gets  
       if is_line_of_code( line.lstrip  )
          #puts "line> #{line}"
         lines_of_code = lines_of_code + 1
       end
    end  
  end
  return lines_of_code
end

filename = ARGV.first
puts "You entered %s" % (filename ? filename : "nothing, so I will read my own file")

lines_of_code = count_lines(filename)
puts '%i LOC' % lines_of_code
