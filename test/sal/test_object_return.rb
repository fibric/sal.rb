require 'helper'

class TestObjectReturn < TestSal

  def test_minimal_html
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
end
