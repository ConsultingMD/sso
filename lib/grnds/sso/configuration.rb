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
    end

    class << self
      def sign_in_url
        configuration = Grnds::Sso.configuration
        configuration.base_site + configuration.sign_in_post_fix
      end

      def sign_out_url
        configuration = Grnds::Sso.configuration
        configuration.base_site + configuration.sign_out_post_fix
      end
    end
  end
end
