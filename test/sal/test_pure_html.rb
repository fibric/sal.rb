require 'helper'

class TestPureHtml < TestSal

  def test_mini_doc
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

  def test_attributes
    source = %q{
<h1 id='title' class='leader'>Simple Attribute Language (SAL)</h1>
}
    assert_html %q{<h1 class='leader' id='title'>Simple Attribute Language (SAL)</h1>}, source
  end

  def test_comment
    source = %q{
<!-- HTML Comments are kinda useless -->
<h1 id='title' class='leader'>Simple Attribute Language (SAL)</h1>
<!-- The
        End.
            Goodbye.-->
}
    assert_html %Q{<!-- HTML Comments are kinda useless --><h1 class='leader' id='title'>Simple Attribute Language (SAL)</h1><!-- The\n        End.\n            Goodbye.-->}, source
  end

end
