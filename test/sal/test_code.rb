require 'helper'

class TestCode < TestSal

  def test_simple_call
    source = %q{
<h1 data-sal='title'>This will be replaced</h1>
}
    assert_html %q{<h1>Sal test</h1>}, source
  end

  def test_array_of_strings
    source = %q{
<ul>
  <li data-sal='array_of_strings'>This content will be replaced</li>
</ul>
}
    assert_html %q{<ul><li>one</li><li>two</li><li>three</li></ul>}, source
  end

  def test_single_object
    source = %q{
<h1 data-sal='user_header'>This will be replaced</h1>
}
    assert_html %q{<h1 id='user_header'>User details</h1>}, source
  end

  def test_array_of_objects
    source = %q{
<ul>
  <li data-sal='doggies'>Doggies!</li>
</ul>
}
    assert_html %q{<ul><li id='dog_1'>Monty</li><li id='dog_2'>Rupert</li><li id='dog_3'>Kaylee</li></ul>}, source

  end

end
