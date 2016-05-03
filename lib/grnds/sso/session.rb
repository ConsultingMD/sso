module Grnds
  module Sso
    module Session
      extend ActiveSupport::Concern

      protected

      def self.base_fields
        {
          customer_name: -> (user){ user.try(:customer_name) },
          uid:           -> (user){ user.try(:uid) },
          first_name:    -> (user){ user.try(:first_name) },
          last_name:     -> (user){ user.try(:last_name )}
        }
      end

      def self.set_credentials(session: nil, user: current_user, extras: {})
        session ||= self.attempt(:session)
        base_fields.each{|key, proc| session[key] = proc.call(user) }
        set_session_vars session vars: extras
      end

      def self.set(session, vars: {})
        vars.each{|key, val| session[key] = val }
      end
    end
  end
end
