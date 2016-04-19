module Grnds
  module Impersonate
    module ImpersonationHelper
      extend ActiveSupport::Concern

      included do
        helper_method :impersonating?
      end

      ##
      # Returns true if an admin user is impersonating another user.
      def impersonating?
        true_user && true_user != current_user
      end

      ##
      # Returns select options for impersonate roles.
      def options_for_impersonate_user(kase)
        options = []
        patient = kase.patient
        primary = kase.primary
        user, title = patient.medical_releaser_only? ? ['Case Primary', primary] : ['Patient', patient]
        if can_impersonate(user)
          options << [title, impersonate_path(user)]
          options << ['Doctor', impersonate_path(kase.expert)] if kase.doctor_assigned?
        end
        options
      end

      ##
      # Returns true if the staff user can impersonate
      def can_impersonate(user)
        can? :impersonate, user
      end

    end
  end
end