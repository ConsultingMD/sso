module Grnds
  module Impersonate
    module Ability
      extend ActiveSupport::Concern

      def can_impersonate_user(&block)
        can :impersonate, User, &block
      end
    end
  end
end
