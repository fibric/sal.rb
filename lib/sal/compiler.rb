module Sal
  # Compiles HTML into Temple::HTML expressions
  # @api private
  class Compiler < Filter

    def on_sal_tag(ele, attrs, content)
      [:html, :tag, ele, format_attrs(attrs), false, compile(content)]
    end

    def on_sal_code(code, tag, attrs, content)
      tmp1, tmp2 = tmp_var(:sal), tmp_var(:sal)

      [:multi,
        [:block, "#{tmp1} = #{code}"],
        [:block, "if #{tmp1}.kind_of?(String)"],
                      [:html, :tag, tag, format_attrs(attrs), false, [:dynamic, tmp1]],
        [:block, "elsif #{tmp1}.kind_of?(Array)"],
        [:block,    "#{tmp1}.each do |#{tmp2}|"],
                       [:html, :tag, tag, ada(attrs, tmp2), false,
                            [:dynamic, "Sal::U.parse_for_html(#{tmp2})"]],
        [:block,    'end'],
        [:block, "else"],
                    [:html, :tag, tag, ada(attrs, tmp1), false,
                        [:dynamic, "Sal::U.parse_for_html(#{tmp1})"]],
        [:block, 'end'],
      ]
    end

    private

    def format_attrs(attrs)
      a = []
      attrs.each{ |k,v| a << [k, [:static, v]] }
      [:multi, [:html, :staticattrs] + a]
    end

    def ada(attrs, tmpvar)
      [:dynamic,  "Sal::U.parse_for_attributes(#{tmpvar}, #{attrs.inspect})"]
    end
  end
end
