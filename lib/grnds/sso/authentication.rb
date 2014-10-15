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
        session['customer_name'] = 'Grand Rounds'
        session['uid'] = '57'
        session['first_name'] = 'Kenneth'
        session['last_name'] = 'Berland'
      end

      def authenticate_user
        set_development_credentials if %w[development test].include?(Rails.env)
        redirect_to Grnds::Sso.sign_in_url unless authenticated?
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
