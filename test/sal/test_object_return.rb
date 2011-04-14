require 'helper'

class TestObjectReturn < TestSal

  def test_basic_html
    source = %q{
<html>
  <head>
    <title>Sal Test</title>
  </head>
  <body>
    <p>Simple</p>
  </body>
</html>
}
    assert_html '<html><head><title>Sal Test</title></head><body><p>Simple</p></body></html>', source
  end

  def test_basic_html_with_attributes
    source = %q{
<h1 id='title' class='leader'>Simple Attribute Language (SAL)</h1>
}
    assert_html %q{<h1 class='leader' id='title'>Simple Attribute Language (SAL)</h1>}, source
  end

end
