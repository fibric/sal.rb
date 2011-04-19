module Sal
  class Filter < Temple::Filter
    temple_dispatch :sal

    def on_sal_code(code, tag, attrs, content)
      [:sal, :code, code, tag, attrs, content]
    end

    def on_sal_tag(tag, attrs, content)
      [:sal, :tag, tag, attrs, content]
    end
  end
end
