module Grnds::Sso
  class AuthorizationConstraint
  	include Singleton
  	
  	class << self
      delegate :configure, :matches?, to: :instance
    end

    def configure
      yield self
    end

    def matches?(request)
      session = request.session
      return session['primary_role'].eql?('admin')
    end
  end
end