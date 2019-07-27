# frozen_string_literal: true

# typed: strict

module Grnds
  module Sso
    module Authentication
      extend ActiveSupport::Concern
      extend T::Sig

      include Grnds::Sso::ViewHelpers

      module ClassMethods
        extend T::Sig
        sig { params(options: T::Hash[T.any(String, Symbol), T.any(String, Symbol)]).void }
        def grnds_sso_access(options = {})
          T.unsafe(self).before_filter :authenticate_user, options
        end
      end

      # sig { void }
      # def set_development_credentials
      #   session['warden.user.user.key'] ||= [[2]]
      #   session['customer_name'] ||= 'Grand Rounds'
      #   session['uid'] ||= '57'
      #   session['first_name'] ||= 'Kenneth'
      #   session['last_name'] ||= 'Berland'
      #   session['institution_name'] ||= 'Hospital for Special Services'
      # end

      sig { void }
      def authenticate_user
        # set_development_credentials if %w[test].include?(Rails.env)
        # how do we do this without T.unsafe?
        return unless authenticated?

        T.unsafe(self).redirect_to(
          Grnds::Sso.sign_in_url(return_to: T.unsafe(self).request.url)
        )
      end

      sig { returns(T::Boolean) }
      def authenticated?
        # session[:init] = true unless session.loaded?
        current_user.present?
      end
    end
  end
end
