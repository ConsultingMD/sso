module Grnds
  module Sso
    module Authorization
      extend ActiveSupport::Concern

      included do
        helper_method :authorized_for?
      end

      def authorized_for?(request, roles)
        AuthorizationConstraint.new(roles).matches?(request)
      end
    end
  end
end
