require 'helper'

class TestObjectReturn < TestSal

  def test_basic_html
    source = %q{
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>Sal Test</title>
  </head>
  <body>
    <p>Simple</p>
  </body>
</html>
}
    assert_html '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html><head><title>Sal Test</title></head><body><p>Simple</p></body></html>', source
  end

  def test_basic_html_with_attributes
    source = %q{
<h1 id='title' class='leader'>Simple Attribute Language (SAL)</h1>
}
    assert_html %q{<h1 class='leader' id='title'>Simple Attribute Language (SAL)</h1>}, source
  end

end
