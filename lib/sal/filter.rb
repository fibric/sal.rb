module Sal
  class Filter < Temple::Filter
    temple_dispatch :sal

    def on_sal_code(code, markup)
      [:sal, :code, code, markup]
    end
  end
end
