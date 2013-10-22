# code_counter.rb
=begin
   Read the file that you pass by as first argument
   in the terminal and tell you how many line of code have that file.
   
   Ignore: 
   1. In-line comments. Every line start with #.
   2. Empty line
   3. Block comments. Everything between =begin and =end 
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

def is_start_block_comment(line)
  return line.start_with?("=begin")  
end

def is_fin_block_comment(line)
  return line.start_with?("=end")  
end

def count_lines(file_entered, print_lines_of_code)
  file_to_read = file_entered ? file_entered : $0
  
  lines_of_code = 0
  block_comment_started = false

  File.open(file_to_read, 'r') do |f1|  
    while line = f1.gets  
      if block_comment_started
          if is_fin_block_comment(line)
            block_comment_started = false
          end
      elsif is_start_block_comment(line)
          block_comment_started = true
      elsif is_line_of_code( line.lstrip  )
        lines_of_code = lines_of_code + 1
        if print_lines_of_code 
          puts " #{lines_of_code}> #{line}"
        end
      end
    end
  end
  return lines_of_code
end

filename = ARGV.first
puts "You entered %s" % (filename ? filename : "nothing, so I will read my own file")

print_lines_of_code = false


lines_of_code = count_lines(filename, print_lines_of_code)
puts '%i LOC' % lines_of_code
