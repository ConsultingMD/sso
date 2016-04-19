module Grnds
  module Impersonate
    module PathHelper

      protected

      ##
      # Returns the path to return to after impersonation ends.
      # If this path is nil, it returns the admin's home path.
      def impersonate_before_path
        session.delete(:impersonate_before_path) || my_home_path
      end

      ##
      # Returns the admin path to the impersonate action.
      def impersonate_path(user)
        impersonate_admin_stark_user_path(user)
      end

      ##
      # Returns the admin path to the impersonate medical questions action.
      def impersonate_medical_questions_path(kase)
        medical_questions_admin_stark_user_path(case_primary(kase), case_id: kase.to_param)
      end

      ##
      # Return the case path for the given user. For doctors it's the active opinions path.
      def user_case_path(kase: nil, user: nil)
        opinion = kase.attempt(:doctor_opinion)
        path = attempt(:opinion_path, opinion) if opinion.present? && user.doctor?
        path ||= attempt(:case_path, kase) if kase.present?
        return path if path.present?
        attempt(:my_home_path, user) || attempt(:root_path)
      end

      ##
      # Returns the default impersonation path based on the current service.
      def default_impersonate_path(kase: nil, user: nil)
        case service_name
          when :jarvis then user_case_path(kase: kase, user: user)
          when :banyan then attempt(:active_opinions_path)
        end
      end

      ##
      # Returns the path
      def impersonate_user_path(kase)
        user = case_primary(kase)
        return unless kase && user
        impersonate_path(user) if can_impersonate(user)
      end
    end
  end
end