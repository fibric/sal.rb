module Sal
  class Engine < Temple::Engine
    set_default_options :generator => Temple::Generators::ArrayBuffer

    use Sal::Parser, :file, :tabsize, :encoding
    use Sal::Compiler
    use Temple::HTML::Fast

    filter :MultiFlattener    # Collapse nested multis into single multi
    filter :StaticMerger      # Merge several statics into a single static
    filter :DynamicInliner    # Merge several static/dynamic into single dynamic

    use(:Generator) { |exp| options[:generator].new(options).call(exp) }
  end
end
