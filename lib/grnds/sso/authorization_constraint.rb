module Grnds::Sso
  class AuthorizationConstraint
    attr_reader :roles

    def initialize(roles)
      @roles = roles
    end

    def authenticated?(request)
      session = request.session
      session[:init] = true unless session.loaded?
      session['uid'].present?
    end

    def authorized?(request)
      roles.include?(request.session['primary_role'])
    end

    def matches?(request)
      authenticated?(request) && authorized?(request)
    end
  end
end
