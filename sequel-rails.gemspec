# -*- encoding: utf-8 -*-
require "date"

Gem::Specification.new do |s|
  s.name             = %q{sequel-rails}
  s.version          = "0.1.7"
  s.date             = Date.today.to_s
  s.authors          = ["Brasten Sager (brasten)", "Fred Wu"]
  s.email            = %q{brasten@gmail.com, ifredwu@gmail.com}
  s.homepage         = %q{http://github.com/fredwu/sequel-rails}
  s.summary          = %q{Integrate Sequel with Rails 3}
  s.description      = %q{Integrate Sequel with Rails 3}
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_paths    = ["lib"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files            = `git ls-files --  lib/* bin/* README.md`.split("\n")

  s.add_dependency(%q<sequel>, ["~> 3.13"])
  s.add_dependency(%q<activesupport>, ["~> 3.0"])
  s.add_dependency(%q<actionpack>, ["~> 3.0"])
  s.add_dependency(%q<railties>, ["~> 3.0"])

  s.add_development_dependency(%q<yard>, ["~> 0.5"])
  s.add_development_dependency(%q<rspec>, ["~> 2.6"])
  s.add_development_dependency(%q<autotest>)
  s.add_development_dependency(%q<simplecov>)
end

