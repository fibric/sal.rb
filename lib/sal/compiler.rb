module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Temple::Filter
    def call(exp)
      [:multi,
       [:code, "_saldict = Sal::Wrapper.new(self)"],
       super]
    end

    def on_sal_tag(tag, attrs, content)
      [:html, :tag, tag, format_attrs(attrs), compile(content)]
    end

    def on_sal_text(incode, text)
      if incode
        [:dynamic, "Sal::U.parse_for_html(_saldict, '#{text}')"]
      else
        [:static, text]
      end
    end

    def on_sal_code(code, tag, attrs, content)
      tmp1, tmp2 = unique_name, unique_name
      content = compile(content)
      [:if, "(#{tmp1} = _saldict['#{code}'])",
       [:multi,
        [:code, "#{tmp2}  = _saldict"],
        [:code, "_saldict = #{tmp1}"],
        [:case, tmp1,
         ['Array',
          [:block, "#{tmp1}.each do |_saldict|",
           [:html, :tag, tag, ada(attrs), content]]],
         [:else,
          [:html, :tag, tag, ada(attrs), content]]],
        [:code, "_saldict = #{tmp2}"]]]
    end

    private

    def format_attrs(attrs)
      attrs.inject([:html, :attrs]) {|a, (k,v)| a << [:html, :attr, k, [:static, v]] }
    end

    def ada(attrs)
      [:dynamic,  "Sal::U.parse_for_attributes(_saldict, #{attrs.inspect})"]
    end
  end
end
