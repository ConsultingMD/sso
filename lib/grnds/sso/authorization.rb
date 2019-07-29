module Grnds
  module Sso
    module Authorization
      extend ActiveSupport::Concern

      def authorized_for?(request, roles)
        AuthorizationConstraint.new(roles).matches?(request)
      end
    end
  end
end
