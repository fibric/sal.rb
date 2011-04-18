module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Filter

    def on_sal_code(code, tag, attrs, content)
      tmp1 = tmp_var(:res)

      [:multi,
        [:block, "if #{tmp1} = #{code}"],
          [:block, "if #{code}.kind_of?(String)"],
            [:html, :tag, tag, attrs, false, [:dynamic, code]],
          [:block, 'end'],
        [:block, 'end']
      ]
    end
  end
end
