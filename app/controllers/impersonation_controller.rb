module Grnds
  module Impersonate
    class ImpersonationController < ApplicationController
      include ImpersonationHelper

      ##
      # Helper method to initiate an admin user impersonating another user.
      def impersonate(route = nil)
        session[:impersonate_before_path] = request.referer
        user, kase = @user, fetch_case
        route ||= default_impersonate_path(kase: kase, user: user)

        impersonate_user(user)
        record_case_impressions if kase.present?

        redirect_to route
      end

      ##
      # Stops the user impersonation, and returns the admin to the path
      # he started at before the impersonation (usually the case path).
      def stop_impersonation
        stop_impersonating_user
        redirect_to impersonate_before_path
      end

    end
  end
end
