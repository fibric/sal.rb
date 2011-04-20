# encoding: utf-8

require 'minitest/unit'
require 'sal'

MiniTest::Unit.autorun

class Env
  def title
    "Sal test"
  end

  def array_of_strings
    %w{one two three}
  end

  def user_header
    {:id    => 'user_header',
     :html  => 'User details' }
  end
end

class TestSal < MiniTest::Unit::TestCase
  def setup
    @env = Env.new
  end

  def render(source, options = {}, &block)
    tmpl = Sal::Template.new(options[:file], options) { source }
    #TODO: just for debugging...will remove later
    # puts tmpl.precompiled_template
    tmpl.render(options[:scope] || @env, &block)
  end

  def assert_html(expected, source, options = {}, &block)
    assert_equal expected, render(source, options, &block)
  end
end #TestSal
