require 'helper'

class TestPureHtml < TestSal

  def test_mini_doc
    source = %q{
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Sal Test</title>
  </head>
  <body>
    <p>Simple</p>
  </body>
</html>
}
    assert_html '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title>Sal Test</title></head><body><p>Simple</p></body></html>', source
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

  def test_conditional_comment
    source = %q{
  <!--[ if IE ]>
    <p>Get a better browser.</p>
  <![endif]-->
}

    assert_html %Q{<!--[ if IE ]>\n    <p>Get a better browser.</p>\n  <![endif]-->}, source
  end

  def test_attributes
    source = %q{
<h1 id='title' class='leader'>Simple Attribute Language (SAL)</h1>
}
    assert_html %q{<h1 class='leader' id='title'>Simple Attribute Language (SAL)</h1>}, source
  end

  def test_selfclosing_tag
    source = %q{
<a href='#'><img src='/path/to/img.png'/></a>
}
    assert_html %q{<a href='#'><img src='/path/to/img.png' /></a>}, source
  end

end
