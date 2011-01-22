module Sal
  class Filter < Temple::Filter
    temple_dispatch :sal

    def on_sal_code(name, content)
      tmp1 = tmp_var('res')

      [:multi,
        [:block, "if #{tmp1} = #{name}"], 
                    content,
        [:block, 'end']]
    end

    def tmp_var(prefix)
      @tmp_var ||= 0
      "_sal#{prefix}#{@tmp_var += 1}"
    end
  end
end
