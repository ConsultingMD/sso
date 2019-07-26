# typed: false
module Grnds
  module Sso
    module ViewHelpers
      extend ActiveSupport::Concern
      included do
        helper_method :current_user
        helper_method :current_user_id
        helper_method :current_customer
        helper_method :current_institution
        helper_method :current_first_name
        helper_method :current_last_name
      end
      def current_user
        session['uid']
      end

      def current_user_id
        # Warden structures its session key as:
        # { 'warden.user.{model_name}.key' => [[id], [partial_password_hash]] }

        session['warden.user.user.key'].tap do |maybe|
          return maybe.first.first if maybe
        end
      end

      def current_customer
        session['customer_name']
      end

      def current_institution
        session['institution_name']
      end

      def current_first_name
        session['first_name']
      end

      def current_last_name
        session['last_name']
      end
    end
  end
end
