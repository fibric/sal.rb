module Sal
  class Engine < Temple::Engine
    use Sal::Parser, :file, :tabsize
    use Sal::Compiler
    filter :MultiFlattener    # Collapse nested multis into single multi
    filter :StaticMerger      # Merge several statics into a single static
    filter :DynamicInliner    # Merge several static/dynamic into single dynamic
    generator :ArrayBuffer
  end
end
