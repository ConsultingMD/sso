lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grnds/sso/version'

Gem::Specification.new do |s|
  s.name        = 'grnds-sso'
  s.version     = Grnds::Sso::VERSION
  s.date        = '2014-12-29'
  s.summary     = 'SSO for Grand Rounds'
  s.description = 'A simple way to expose SSO on Grand Rounds projects'
  s.authors     = ['Justin Ahn', 'Rick Cobb']
  s.email       = 'justin@grandroundshealth.com'
  s.license     = 'MIT'

  all_files     = `git ls-files`.split("\n")
  test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.files       = all_files - test_files
  s.test_files  = test_files

  s.add_development_dependency 'rspec_junit_formatter', '0.4.1'
  s.add_dependency 'grnds-auth0'
end
