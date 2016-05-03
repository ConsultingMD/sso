require 'grnds/sso/version'
require 'grnds/sso/configuration'

if defined?(Rails)
  require 'grnds/sso/view_helpers' 
  require 'grnds/sso/authentication'
  require 'grnds/sso/vpn_constraint'
  require 'grnds/sso/session'
end
