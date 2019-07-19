module Grnds::Sso
  class AuthorizationConstraint
    attr_accessor :roles

    def initialize(roles)
      self.roles = roles
    end

    def authenticated?(request)
      session = request.session
      session[:init] = true unless session.loaded?

      return session['uid'].present?
    end

    def authorized?(request)
      session = request.session
      return true if session['primary_role'] == 'admin'
      return roles.include?(session['primary_role'])
    end

    def matches?(request)
      return authenticated?(request) && authorized?(request)
    end
  end
end
