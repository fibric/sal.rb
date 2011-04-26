# encoding: utf-8

module Sal
  class U 
    class << self
      def parse_for_attributes(result = nil, attrs = {})
        result = result.value if result.kind_of?(Sal::Wrapper)

        return unless result.kind_of?(Hash)

        result = stringify_keys(result)

        # concat values on class attribute
        if attrs['class'] && result['class']
          result['class'] = attrs['class'] + ' ' + result['class']
        end

        " #{result.collect{ |k,v| "#{k}='#{v}'" unless k.to_s == 'html' }.compact.join(' ')}"
      end

      def parse_for_html(result, text = '')
        result = result.value if result.kind_of?(Sal::Wrapper)
        if result.kind_of?(String)
          result
        elsif result.kind_of?(Hash)
          result.delete(:html)
        else
          text unless text.strip.empty?
        end
      end

      private

      def stringify_keys(result)
        new = {}
        result.each{ |k,v| new[k.to_s] = v }
        new
      end
    end
  end
end
