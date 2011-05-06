require 'nokogiri'

module Sal
  class Parser
    include Temple::Mixins::Options

    set_default_options :encoding => 'utf-8'

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
      parse_nodeset([result], Nokogiri::XML(str))
      result
    end

    private

    def parse_nodeset(stacks, nodes, incode = false)
      nodes.children.each do |node|
        tag = node.name

        case node.type
        when Nokogiri::XML::Node::ELEMENT_NODE
          content = [:multi]
          attrs, code = parse_attrs(node)
          if code
            incode = true
            stacks.last << [:sal, :code, code, tag, attrs, content]
          else
            incode = false
            stacks.last << [:sal, :tag, tag, attrs, content]
          end
          stacks << content
          parse_nodeset(stacks, node, incode)
          stacks.pop
        when Nokogiri::XML::Node::TEXT_NODE
          str = node.text
          if str.strip.empty?
            stacks.last << [:newline]
          else
            stacks.last << [:sal, :text, incode, str]
          end
        when Nokogiri::XML::Node::DTD_NODE
          stacks.last << [:static, node.to_s]
        when Nokogiri::XML::Node::COMMENT_NODE
          stacks.last << [:html, :comment, [:static, node.text]]
        end
      end
    end

    def parse_attrs(node)
      code  = nil
      attrs = {}

      node.attribute_nodes.each do |an|
        if an.name == 'data-sal'
          code = an.value
        else
          attrs[an.name.to_s] = an.value
        end
      end

      return attrs, code
    end
  end
end
