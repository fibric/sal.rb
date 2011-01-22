# encoding: utf-8

require 'minitest/unit'
require 'sal'

MiniTest::Unit.autorun

class Env
  def title
    "Sal test"
  end
end

class TestSal < MiniTest::Unit::TestCase
  def setup
    @env = Env.new
  end

  def render(source, options = {}, &block)
    Sal::Template.new(options[:file], options) { source }.render(options[:scope] || @env, &block)
  end

  def assert_html(expected, source, options = {}, &block)
    assert_equal expected, render(source, options, &block)
  end
end #TestSal
