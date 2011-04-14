require 'nokogiri'

module Sal
  class Parser
    include Temple::Mixins::Options

    set_default_options :tabsize => 4,
                        :encoding => 'utf-8'

    def initialize(options = {})
      super
      @tab = ' ' * @options[:tabsize]
    end

    # Compile the string to a Temple expression
    #
    # @param [String] str Html code
    # @return [Array] Temple expression representing the code
    def call(str)
      if options[:encoding] && str.respond_to?(:encoding)
        old = str.encoding
        str = str.dup if str.frozen?
        str.force_encoding(options[:encoding])
        # Fall back to old encoding if new encoding is invalid
        str.force_encoding(old_enc) unless str.valid_encoding?
      end

      result = [:multi]

      doc = Nokogiri::XML(str)

      parse_nodeset([result], doc)

      result
    end

    private

    def parse_nodeset(stacks, nodes)
      nodes.children.each do |node|
        ele = node.name

        if node.text?
          str = node.text
          if str.strip.empty?
            stacks.last << [:newline]
          else
            stacks.last << [:static, str] 
          end
        else
          content = [:multi]
          stacks.last << [:html, :tag, ele, parse_attrs(node), false, content] 
          stacks << content
          parse_nodeset(stacks, node) 
          stacks.pop
        end
      end
    end

    def parse_attrs(node)
      attrs = []
      [ :html, :staticattrs] #, ['id', [:static, 'test']] ]
    end
  end
end
