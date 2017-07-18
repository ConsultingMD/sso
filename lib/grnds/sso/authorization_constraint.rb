module Grnds::Sso
  class AuthorizationConstraint

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

    def matches?(request)
      session = request.session
      return false if session['uid'].eql?(nil)
      return session['primary_role'].eql?(self.role)
    end
  end
end
