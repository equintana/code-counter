=begin
   Read the file that you pass by as first argument in the terminal and tell you how many line of code have that file.
   
   Ignore: 
   1. In-line comments. Every line start with #.
   2. Empty lines.
   3. Block comments. Everything between =begin and =end.
=end
class CodeCounter

  IN_LINE_COMMENT = "#"
  START_BLOCK_COMMENT = "=begin"
  END_BLOCK_COMMENT = "=end"

  attr_accessor :print_lines_of_code

  def count_lines( file_entered )
  
    file_to_read = file_entered ? file_entered : $0
    lines_of_code = 0
    block_comment_started = false

    File.open(file_to_read, 'r') do |file|  
      while line = file.gets  
        if block_comment_started
            if line.start_with?( END_BLOCK_COMMENT )
              block_comment_started = false
            end
        elsif line.start_with?( START_BLOCK_COMMENT )
            block_comment_started = true
        elsif is_line_of_code( line.lstrip  )
          lines_of_code = lines_of_code + 1
          if @print_lines_of_code 
            puts " #{lines_of_code}> #{line}"
          end
        end
      end
    end
    lines_of_code
  end

  def is_line_of_code( line )
    if line.empty? || line.start_with?( IN_LINE_COMMENT )
      return false
    end
    return true
  end

end

filename = ARGV.first
puts "You entered %s" % ( filename ? filename : "nothing, so I will read my own file" )

counter = CodeCounter.new 
counter.print_lines_of_code = false
puts '%i LOC' % counter.count_lines(filename)
