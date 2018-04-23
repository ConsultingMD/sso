module Grnds::Sso
  class VpnConstraint
    include Singleton

    LOCALHOST = '127.0.0.1'.freeze
    VPN = %r{^10\.}.freeze

    class << self
      delegate :configure, :matches?, to: :instance
    end

    attr_accessor :pattern

    def initialize
      # Our deployments use nginx in a way that hides the source IP address
      self.pattern = LOCALHOST
    end

    def configure
      yield self
    end

    def matches?(request)
      authenticated?(request) && on_the_vpn?(request)
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
