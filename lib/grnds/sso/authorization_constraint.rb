module Grnds::Sso
  class AuthorizationConstraint

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

    def authenticated?(request)
      session = request.session
      session[:init] = true unless session.loaded?

      return session['uid'].present?
    end

    def authorized?(request)
      session = request.session
      return session['primary_role'] == (self.role)
    end

    def matches?(request)
      return authenticated?(request) && authorized?(request)
    end
  end
end
