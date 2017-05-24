module Grnds
  module Sso
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Grnds::Sso::Configuration.new
    end

    class Configuration
      attr_accessor :base_site, :sign_in_post_fix, :sign_out_post_fix

      def initialize
        @sign_in_post_fix = '/users/sign_in'
        @sign_out_post_fix = '/users/sign_out'
      end

      def vpn
        Grnds::Sso::VpnConstraint.instance
      end
    end

    class << self
      def sign_in_url(query={})
        configuration = Grnds::Sso.configuration
        url = configuration.base_site + configuration.sign_in_post_fix
        url += "?#{query.to_param}" if params.present?
        url
      end

      def sign_out_url
        configuration = Grnds::Sso.configuration
        configuration.base_site + configuration.sign_out_post_fix
      end
    end
  end
end
