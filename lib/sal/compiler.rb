module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Filter

    def on_sal_tag(ele, attrs, closed, content)
      [:html, :tag, ele, attrs, closed, compile(content)]
    end

    def on_sal_code(code, tag, attrs, content)
      tmp1, tmp2 = tmp_var(:res), tmp_var(:res)

      [:multi,
        [:block, "if #{tmp1} = #{code}"],
          [:block, "if #{tmp1}.kind_of?(String)"],
                      [:html, :tag, tag, attrs, false, [:dynamic, tmp1]],
          [:block, "elsif #{tmp1}.kind_of?(Array)"],
          [:block,    "#{tmp1}.each do |#{tmp2}|"],
                         [:html, :tag, tag, attrs, false, [:dynamic, "Sal.parse_for_html(#{tmp2})"]],
          [:block,    'end'],
          [:block, "else"],
                      [:html, :tag, tag, attrs, false, [:dynamic, "Sal.parse_for_html(#{tmp1})"]],
          [:block, 'end'],
        [:block, 'end']
      ]
    end
  end
end
