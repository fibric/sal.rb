require 'helper'

class TestCode < TestSal

  def test_simple_call
    source = %q{
<h1 data-sal='title'>This will be replaced</h1>
}
    assert_html %q{<h1>Sal test</h1>}, source
  end

end
