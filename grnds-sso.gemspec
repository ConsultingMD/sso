lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grnds/sso/version'

Gem::Specification.new do |s|
  s.name        = 'grnds-sso'
  s.version     = Grnds::Sso::VERSION
  s.date        = '2014-12-29'
  s.summary     = "SSO for Grand Rounds"
  s.description = "A simple way to expose SSO on Grand Rounds projects"
  s.authors     = ["Justin Ahn", "Rick Cobb"]
  s.email       = 'justin@grandroundshealth.com'
  s.files       = `git ls-files`.split($/)
  s.license     = 'MIT'    
end