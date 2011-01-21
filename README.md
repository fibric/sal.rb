# sal.rb

sal.rb is a simple attribute language for Ruby. 

## What?

This project is a refactor of [RuHL](http://github.com/stonean/ruhl) that uses [Temple](https://github.com/judofyr/temple) and [Tilt](https://github.com/rtomayko/tilt).

## How?

Install it
    
    gem install sal

If you want to use the sal template directly, you can use the Tilt interface:

    Tilt.new['template.sal'].render(scope)
    Sal::Template.new(filename, optional_option_hash).render(scope)
    Sal::Template.new(optional_option_hash) { source }.render(scope)

## Syntax
