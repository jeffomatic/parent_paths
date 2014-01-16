# encoding: utf-8
$:.unshift File.expand_path("../lib", __FILE__)
require 'parent_paths/version'

Gem::Specification.new do |s|
  s.name = 'parent_paths'
  s.licenses = ['MIT']
  s.summary = "Handy methods for scanning parent paths"
  s.version = ParentPaths::VERSION
  s.homepage = 'https://github.com/jeffomatic/parent_paths'

  s.authors = ["Jeff Lee"]
  s.email = 'jeffomatic@gmail.com'

  s.files = %w( README.md LICENSE parent_paths.gemspec )
  s.files += Dir.glob('lib/**/*')

  s.add_development_dependency('rspec', '~>2.14.1')
end