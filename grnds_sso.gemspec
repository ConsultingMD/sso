lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grnds_sso/version'

Gem::Specification.new do |s|
  s.name        = 'grnds_sso'
  s.version     = GrndsSSO::VERSION
  s.date        = '2010-09-24'
  s.summary     = "SSO for Grand Rounds"
  s.description = "A simple way to expose SSO on Grand Rounds projects"
  s.authors     = ["Justin Ahn"]
  s.email       = 'justin@grandroundshealth.com'
  s.files       = ["lib/hola.rb"]
  s.license     = 'MIT'
end
