module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Filter

    def on_sal_tag(tag, attrs, content)
      [:html, :tag, tag, format_attrs(attrs), false, compile(content)]
    end

    def on_sal_text(incode, text)
      if incode
        [:dynamic, "Sal::U.parse_for_html(_saldict, '#{text}')"]
      else
        [:static, text]
      end
    end

    def on_sal_code(code, tag, attrs, content)
      tmp1, tmp2 = tmp_var(:sal), tmp_var(:sal)
      content = compile(content)
      [:multi,
        [:block,  "if (#{tmp1} = _saldict['#{code}'])"],
        [:block,    "#{tmp2}  = _saldict"],
        [:block,    "_saldict = #{tmp1}"],
        [:block,    "case (#{tmp1})"],
        [:block,    "when Array"],
        [:block,      "#{tmp1}.each do |_saldict|"],
                        [:html, :tag, tag, ada(attrs), false, content],
        [:block,      'end'],
        [:block,    "else"],
                      [:html, :tag, tag, ada(attrs), false, content],
        [:block,    'end'],
        [:block,    "_saldict = #{tmp2}"],
        [:block,  'end'],
      ]
    end

    private

    def format_attrs(attrs)
      a = []
      attrs.each{ |k,v| a << [k, [:static, v]] }
      [:multi, [:html, :staticattrs] + a]
    end

    def ada(attrs)
      [:dynamic,  "Sal::U.parse_for_attributes(_saldict, #{attrs.inspect})"]
    end
  end
end
