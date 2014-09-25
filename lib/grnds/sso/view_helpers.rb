module Grnds
  module Sso
    module ViewHelpers
      extend ActiveSupport::Concern
      included do
        helper_method :current_user
        helper_method :current_customer
        helper_method :current_first_name
        helper_method :current_last_name
      end
      def current_user
        session['uid']
      end

      def current_customer
        session['customer_name']
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
