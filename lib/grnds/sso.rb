# frozen_string_literal: true

# typed: strong

require 'sorbet-runtime'

module Grnds
  module Sso
    extend T::Sig

    autoload :VERSION, './lib/grnds/sso/version'
    autoload :Configuration, './lib/grnds/sso/configuration'
    autoload :ViewHelpers, './lib/grnds/sso/view_helpers'
    autoload :Authentication, './lib/grnds/sso/authentication'
    autoload :Authorization, './lib/grnds/sso/authorization'
    autoload :VpnConstraint, './lib/grnds/sso/vpn_constraint'
    autoload :AuthorizationConstraint, './lib/grnds/sso/authorization_constraint'
    autoload :CurrentUser, './lib/grnds/sso/current_user'

    sig { params(blk: T.proc.bind(Grnds::Sso::Configuration).void).void }
    def self.configure(&blk)
      configuration.instance_eval(blk)
    end

    @configuration = T.let(Grnds::Sso::Configuration.new, Grnds::Sso::Configuration)
    sig { returns Grnds::Sso::Configuration }
    def self.configuration
      @configuration
    end

    sig { params(query: T::Hash[String, String]).returns(String) }
    def self.sign_in_url(query={})
      configuration = T.let(Grnds::Sso.configuration, Grnds::Sso::Configuration)
      # url = configuration.base_site + configuration.sign_in_post_fix
      # url = url.concat("?#{query.to_param}") if query.present?
      ''
    end

    sig { returns(String) }
    def self.sign_out_url
      configuration = T.let(Grnds::Sso.configuration, Grnds::Sso::Configuration)
      configuration.base_site + configuration.sign_out_post_fix
    end
  end
end
