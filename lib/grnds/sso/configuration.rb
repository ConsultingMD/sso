# frozen_string_literal: true

# typed: strong

module Grnds
  module Sso
    class Configuration
      extend T::Sig

      sig { returns String }
      attr_accessor :base_site, :sign_in_post_fix, :sign_out_post_fix

      sig { void }
      def initialize
        @base_site = T.let('', String)
        @sign_in_post_fix = T.let('/users/sign_in', String)
        @sign_out_post_fix = T.let('/users/sign_out', String)
      end

      sig { returns(Grnds::Sso::VpnConstraint) }
      def vpn
        Grnds::Sso::VpnConstraint.instance
      end
    end
  end
end
