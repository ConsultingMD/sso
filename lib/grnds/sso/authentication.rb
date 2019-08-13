module Grnds
  module Sso
    module Authentication
      extend ActiveSupport::Concern

      module ClassMethods
        def grnds_sso_access(options = {})
          include Grnds::Sso::Authentication
          include Grnds::Sso::ViewHelpers
          before_filter :authenticate_user, options
        end
      end

      protected

      def set_development_credentials
        session['warden.user.user.key'] ||= [[2]]
        session['customer_name'] ||= 'Grand Rounds'
        session['uid'] ||= '57'
        session['first_name'] ||= 'Kenneth'
        session['last_name'] ||= 'Berland'
        session['institution_name'] ||= 'Hospital for Special Services'
      end

      def authenticate_user
        set_development_credentials if %w[test].include?(Rails.env)
        session['uid'] = Jwt::Uid.call(request) if current_user.blank?
        redirect_to Grnds::Sso.sign_in_url(return_to: request.url) unless authenticated?
      end

      def authenticated?
        session[:init] = true unless session.loaded?
        current_user.present?
      end
    end
  end
end

ActionController::Base.class_eval do
  extend Grnds::Sso::Authentication::ClassMethods
end
