require 'helper'

class TestCode < TestSal

  def test_simple_call
    source = %q{
<h1 data-sal='title'>This will be replaced</h1>
}
    assert_html %q{<h1>Sal test</h1>}, source
  end

  def test_class_attribute_combining
    source = %q{
<h1 class='funky' data-sal='home_page_title'>This will be replaced</h1>
}
    assert_html %q{<h1 class='funky home'>Welcome</h1>}, source
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

  def test_array_of_hashes
    source = %q{
<ul>
  <li data-sal='days_of_week'>Monday</li>
</ul>
}
    assert_html %q{<ul><li id='day_1'>Monday</li><li id='day_2'>Tuesday</li><li id='day_3'>Wednesday</li><li id='day_4'>Thursday</li><li id='day_5'>Friday</li><li id='day_6'>Saturday</li><li id='day_7'>Sunday</li></ul>}, source
  end

  def test_array_of_objects
    source = %q{
<tr data-sal='users'>
  <td data-sal='first'>Test</td>
  <td data-sal='last'>User</td>
</tr>
}
    assert_html %q{<tr><td>John</td><td>Smith</td></tr><tr><td>Jane</td><td>Doe</td></tr>}, source
  end

  def test_true_return
    source = %q{ <li data-sal="true_method">Stay</li> }
    assert_html '<li>Stay</li>', source
  end

  def test_false_return
    source = %q{<ul><li data-sal="false_method">Remove</li></ul>}
    assert_html '<ul></ul>', source
  end

  def test_nil_return
    source = %q{<ul><li data-sal="nil_method">Remove</li></ul>}
    assert_html '<ul></ul>', source
  end

  def test_empty_return
    source = %q{<ul><li data-sal="empty_method">Remove</li></ul>}
    assert_html '<ul></ul>', source
  end

  def test_env_access_within_object_scope
    source = %q{
<div data-sal='user'>
  <h1 data-sal='title'>Replace me</h1>
  <p>Welcome <span data-sal='first'>Test</span></p>
</div>
}
    assert_html '<div><h1>Sal test</h1><p>Welcome <span>John</span></p></div>', source
  end
end
