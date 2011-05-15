# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/sal/version"
require "date"

Gem::Specification.new do |s|
  s.name              = "sal"
  s.version           = Sal::VERSION
  s.date              = Date.today.to_s
  s.authors           = ["Andrew Stone"]
  s.email             = ["andy@stonean.com"]
  s.summary           = 'sal is a template language.'
  s.description       = 'sal.rb is an attribute language.'
  s.homepage          = 'http://github.com/stonean/sal.rb'
  s.extra_rdoc_files  = ["README.md"]
  s.rdoc_options      = ["--charset=UTF-8"]
  s.require_paths     = ["lib"]
  s.rubyforge_project = s.name

  s.files         = `git ls-files --  lib/* bin/* README.md`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4"])
  s.add_runtime_dependency(%q<temple>, ["~> 0.3"])
  s.add_runtime_dependency(%q<tilt>, ["~> 1.2"])
end
