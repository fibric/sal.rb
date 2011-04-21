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

  def doggies
    [ {:id    => 'dog_1', :html => 'Monty'},
      {:id    => 'dog_2', :html => 'Rupert'},
      {:id    => 'dog_3', :html => 'Kaylee'} ]
  end

  def home_page_title
    {:class => 'home', :html => 'Welcome'}
  end
end

class TestSal < MiniTest::Unit::TestCase
  def setup
    @env = Env.new
  end

  def render(source, options = {}, &block)
    tmpl = Sal::Template.new(options[:file], options) { source }
    #TODO: just for debugging...will remove later
    #puts '*'*40,tmpl.precompiled_template
    tmpl.render(options[:scope] || @env, &block)
  end

  def assert_html(expected, source, options = {}, &block)
    assert_equal expected, render(source, options, &block)
  end
end #TestSal
