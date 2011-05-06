module Sal
  class Engine < Temple::Engine
    set_default_options   :format => :html,
                          :generator => Temple::Generators::ArrayBuffer

    use Sal::Parser, :file, :encoding
    use Sal::Compiler
    use Temple::HTML::Fast

    filter :ControlFlow
    filter :MultiFlattener    # Collapse nested multis into single multi
    filter :StaticMerger      # Merge several statics into a single static
    filter :DynamicInliner    # Merge several static/dynamic into single dynamic

    use(:Generator) { |exp| options[:generator].new(options).call(exp) }
  end
end
