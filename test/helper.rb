# encoding: utf-8

require 'minitest/unit'
require 'sal'

MiniTest::Unit.autorun

class Obj
  def initialize(hash = {})
    hash.each do |k,v|
      define_singleton_method k, lambda{ v }
    end
  end
end

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

  def days_of_week
    [ { :id => 'day_1', :html => 'Monday'},
      { :id => 'day_2', :html => 'Tuesday'},
      { :id => 'day_3', :html => 'Wednesday'},
      { :id => 'day_4', :html => 'Thursday'},
      { :id => 'day_5', :html => 'Friday'},
      { :id => 'day_6', :html => 'Saturday'},
      { :id => 'day_7', :html => 'Sunday'}]
  end

  def user
    Obj.new({:first => 'John', :last => 'Smith'})
  end

  def users
    [ Obj.new({:first => 'John', :last => 'Smith'}),
      Obj.new({:first => 'Jane', :last => 'Doe'})]
  end

  def home_page_title
    {:class => 'home', :html => 'Welcome'}
  end

  def true_method
    true
  end

  def false_method
    false
  end

  def nil_method
    nil
  end

  def empty_method
    []
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
