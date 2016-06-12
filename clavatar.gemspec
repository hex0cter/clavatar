$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'clavatar'
  s.version     = Clavatar::VERSION
  s.summary     = 'Convert a hash into a Ruby class instance'
  s.description = 'Apply a hash into a Ruby class and return an instance of it.'
  s.authors     = ['Daniel Han']
  s.email       = 'hex0cter@gmail.com'
  s.homepage    = 'https://github.com/hex0cter/clavatar'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*']
  s.required_ruby_version = '>= 2.1.0'
  s.require_paths = ['lib']
end
