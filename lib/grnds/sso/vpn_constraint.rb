module Grnds::Sso
  class VpnConstraint
    include Singleton

    LOCALHOST = '127.0.0.1'.freeze
    VPN = %r{^10\.}.freeze

    class << self
      delegate :configure, :matches?, to: :instance
    end

    attr_accessor :require_login, :pattern
    alias :require_login? :require_login

    def initialize
      self.require_login = (Rails.env != 'development')

      case Rails.env
      when 'development', 'test' then
        self.pattern = LOCALHOST
      else
        self.pattern = VPN
      end
    end

    def configure
      yield self
    end

    def matches?(request)
      return false unless !require_login? || authenticated?(request)

      return on_the_vpn?(request)
    end

    def authenticated?(request)
      session = request.session
      session[:init] = true unless session.loaded?

      return session['uid'].present?
    end

    def on_the_vpn?(request)
      case pattern
      when String
        return pattern == request.remote_ip
      else
        return pattern.match(request.remote_ip)
      end
      raise "VPN not defined"
    end
  end
end
