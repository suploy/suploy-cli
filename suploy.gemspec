# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','suploy','version.rb'])

spec = Gem::Specification.new do |s| 
  s.name = 'suploy'
  s.version = Suploy::VERSION
  s.author = 'flower-pot'
  s.email = 'fbranczyk@gmail.com'
  s.homepage = 'https://github.com/suploy/suploy-cli'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.require_paths = ['lib']
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','suploy.rdoc']
  s.rdoc_options << '--title' << 'suploy' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'suploy'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.10.0')
  s.add_runtime_dependency('highline')
  s.add_runtime_dependency('httparty')
  s.add_runtime_dependency('rugged')
  s.add_runtime_dependency('suploy-api')
  s.add_runtime_dependency('netrc')
  s.add_runtime_dependency('terminal-table')
end
