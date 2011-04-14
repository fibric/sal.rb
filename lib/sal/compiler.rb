module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Filter

    def on_sal_code(name, content)
      tmp1 = tmp_var(:res)

      [:multi,
        [:block, "if #{tmp1} = #{name}"],
        compile(content),
        [:block, 'end']]
    end
  end
end
