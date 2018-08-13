# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'gremlin2dot'
  s.version     = '0.1.3'
  s.date        = '2018-08-13'
  s.summary     = 'Run a gremlin query, and visualise using GraphViz'
  s.description = <<-EOF

  EOF
  s.homepage    = 'http://rve.org.uk/gems/gremlin2dot'
  s.authors     = ['Rachel Evans']
  s.email       = ['rachel@rachelevans.org']
  s.license     = 'Apache-2.0'
  s.require_paths = ["lib"]
  s.files       = Dir.glob(%w[
README.md
Gemfile
Gemfile.lock
bin/*
lib/*.rb
lib/**/*.rb
spec/*.rb
  ])

  s.executables = %w[
    gremlin2dot
  ]

  s.add_runtime_dependency 'rest-client', '~> 2.0'
  s.add_runtime_dependency 'ruby-graphviz', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 3.5'
end
