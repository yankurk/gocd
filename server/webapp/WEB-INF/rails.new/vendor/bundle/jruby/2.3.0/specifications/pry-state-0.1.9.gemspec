# -*- encoding: utf-8 -*-
# stub: pry-state 0.1.9 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-state".freeze
  s.version = "0.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sudhagar".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-06-20"
  s.description = "Pry state lets you to see the values of the instance and local variables in a pry session".freeze
  s.email = ["sudhagar@isudhagar.in".freeze]
  s.homepage = "https://github.com/SudhagarS/pry-state".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Shows the state in Pry Session".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.9"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.3.0", "~> 3.3"])
      s.add_development_dependency(%q<rspec-core>.freeze, [">= 3.3.2", "~> 3.3"])
      s.add_development_dependency(%q<pry-nav>.freeze, ["~> 0.2.4"])
      s.add_development_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_development_dependency(%q<guard-rspec>.freeze, [">= 4.6.3", "~> 4.6"])
      s.add_runtime_dependency(%q<pry>.freeze, ["< 0.11.0", ">= 0.9.10"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.9"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.3.0", "~> 3.3"])
      s.add_dependency(%q<rspec-core>.freeze, [">= 3.3.2", "~> 3.3"])
      s.add_dependency(%q<pry-nav>.freeze, ["~> 0.2.4"])
      s.add_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_dependency(%q<guard-rspec>.freeze, [">= 4.6.3", "~> 4.6"])
      s.add_dependency(%q<pry>.freeze, ["< 0.11.0", ">= 0.9.10"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.9"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.3.0", "~> 3.3"])
    s.add_dependency(%q<rspec-core>.freeze, [">= 3.3.2", "~> 3.3"])
    s.add_dependency(%q<pry-nav>.freeze, ["~> 0.2.4"])
    s.add_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 4.6.3", "~> 4.6"])
    s.add_dependency(%q<pry>.freeze, ["< 0.11.0", ">= 0.9.10"])
  end
end
