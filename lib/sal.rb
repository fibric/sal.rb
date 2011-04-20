# encoding: utf-8

require 'temple'
require 'sal/parser'
require 'sal/filter'
require 'sal/compiler'
require 'sal/engine'
require 'sal/template'
require 'sal/version'

module Sal
  class << self
    def parse_for_attributes(result = nil)
      return unless result.kind_of?(Hash)
      result.delete(:html)
      " #{result.collect{ |k,v| "#{k}='#{v}'" }.join(' ')}"
    end

    def parse_for_html(result = nil)
      if result.kind_of?(String)
        result
      elsif result.kind_of?(Hash)
        result.delete(:html)
      end
    end
  end
end
