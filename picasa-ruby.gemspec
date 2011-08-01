# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{picasa-ruby}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Iskander Haziev}]
  s.date = %q{2011-08-01}
  s.description = %q{Ruby library for Picasa Web Albums API.}
  s.email = %q{gvalmon@gmail.com}
  s.extra_rdoc_files = [%q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{lib/picasa.rb}, %q{lib/picasa/album.rb}, %q{lib/picasa/client.rb}, %q{lib/picasa/photo.rb}]
  s.files = [%q{CHANGELOG}, %q{LICENSE}, %q{Manifest}, %q{README.rdoc}, %q{Rakefile}, %q{init.rb}, %q{lib/picasa.rb}, %q{lib/picasa/album.rb}, %q{lib/picasa/client.rb}, %q{lib/picasa/photo.rb}, %q{picasa-ruby.gemspec}]
  s.homepage = %q{http://github.com/23ninja/picasa-ruby}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Picasa-ruby}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{picasa-ruby}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Ruby library for Picasa Web Albums API.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<oauth>, [">= 0"])
      s.add_development_dependency(%q<typhoeus>, [">= 0"])
    else
      s.add_dependency(%q<oauth>, [">= 0"])
      s.add_dependency(%q<typhoeus>, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0"])
    s.add_dependency(%q<typhoeus>, [">= 0"])
  end
end
