# frozen_string_literal: true

# typed: strict
module Grnds
  module Sso
    module ViewHelpers
      extend ActiveSupport::Concern
      extend T::Sig

      # included do
      #   helper_method :current_user
      #   helper_method :current_user_id
      #   helper_method :current_customer
      #   helper_method :current_institution
      #   helper_method :current_first_name
      #   helper_method :current_last_name
      # end

      sig { void }
      def initialize
        super
        @current_user = T.let(Grnds::Sso::CurrentUser.new(
          user_id: '', primary_role: '', first_name: '', last_name: ''
        ), Grnds::Sso::CurrentUser)
      end

      sig { returns(Grnds::Sso::CurrentUser) }
      attr_reader :current_user

      sig { returns(String) }
      def current_user_id
        # Warden structures its session key as:
        # { 'warden.user.{model_name}.key' => [[id], [partial_password_hash]] }

        current_user.user_id
        # session['warden.user.user.key'].tap do |maybe|
        #   return maybe.first.first if maybe
        # end
      end

      sig { returns(T.nilable(String)) }
      def current_customer
        current_user.customer_name
      end

      sig { returns(T.nilable(String)) }
      def current_institution
        current_user.institution_name
      end

      sig { returns(String) }
      def current_first_name
        current_user.first_name
      end

      sig { returns(String) }
      def current_last_name
        current_user.last_name
      end
    end
  end
end
