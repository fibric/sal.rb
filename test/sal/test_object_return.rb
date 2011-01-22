require 'helper'

class TestObjectReturn < TestSal

  def test_title_change
    source = %q{
  <title data-sal="title">Replace this!</title>
}
    assert_html '<title>Sal test</title>', source
  end
end
