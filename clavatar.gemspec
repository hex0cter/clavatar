$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'clavatar'
  s.version     = Clavatar::VERSION
  s.summary     = 'Class avatar which convert a hash to an object'
  s.description = 'Class avatar which convert a hash to an object'
  s.authors     = ['Daniel Han']
  s.email       = 'hex0cter@gmail.com'
  s.homepage    = 'https://github.com/hex0cter/clavatar'
  s.license     = 'MIT'
  s.files         = Dir['lib/**/*']
  s.required_ruby_version = '>= 2.0.0'
  s.require_paths = ['lib']
end
