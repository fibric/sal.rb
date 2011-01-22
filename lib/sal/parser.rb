module Sal
  class Parser
    # Compile the string to a Temple expression
    #
    # @param [String] str Html code
    # @return [Array] Temple expression representing the code
    def compile(str)
      result = [:multi]

      str.each_line do |line|
        # remove newline
        line.chomp!

        # remove the indentation
        line.lstrip!

        if line.empty?
          result << [:newline]
          next
        end

        result << [:static, line]  
      end
      puts result.inspect
      result
    end
  end
end
