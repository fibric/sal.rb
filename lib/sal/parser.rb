require 'nokogiri'

module Sal
  class Parser
    include Temple::Mixins::Options

    set_default_options :tabsize => 4,
                        :encoding => 'utf-8'

    class << self
      #TODO: Remove node_types after fleshing out tests
      def node_types
        @node_types ||= define_node_types
      end

      private
      def define_node_types
        nt = {}
        Nokogiri::XML::Node.constants.each do |name|
          nt[eval("Nokogiri::XML::Node::#{name}")] = name if name =~ /_NODE$/
        end
        nt
      end
    end # class block

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

        case node.type
        when Nokogiri::XML::Node::ELEMENT_NODE
          content = [:multi]
          stacks.last << [:html, :tag, ele, parse_attrs(node), false, content] 
          stacks << content
          parse_nodeset(stacks, node) 
          stacks.pop
        when Nokogiri::XML::Node::TEXT_NODE
          str = node.text
          if str.strip.empty?
            stacks.last << [:newline]
          else
            stacks.last << [:static, str] 
          end
        when Nokogiri::XML::Node::DTD_NODE
          stacks.last << [:static, node.to_s]
        when Nokogiri::XML::Node::COMMENT_NODE
          stacks.last << [:html, :comment, [:static, node.text]]
        else
          raise "Unexpected node type: #{self.class.node_types[node.node_type]}"
        end
      end
    end

    def parse_attrs(node)
      attrs = node.attribute_nodes.collect{|an| [an.name, [:static, an.value]] }

      if attrs.empty?
        [ :html, :staticattrs]
      else
        [ :html, :staticattrs] + attrs
      end
    end
  end
end
