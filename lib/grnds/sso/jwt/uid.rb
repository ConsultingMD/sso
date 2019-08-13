module Grnds
  module Sso
    module Jwt
      HEADER = 'Authorization'.freeze
      COOKIE = 'user_auth0_token'.freeze
      UID_CLAIM = :'https://grandrounds.com/email'.freeze

      class Uid
        class << self
          def call(request)
            request_token = token_from(request)
            return unless request_token.present?

            token = Grnds::Auth0::Token.new(request_token)
            token.verify!
            uid_from(token)
          end

          private def token_from(request)
            request.headers[HEADER].presence ||
            request.cookies[COOKIE].presence
          end

          private def uid_from(token)
            token.payload[UID_CLAIM]
          end
        end
      end
    end
  end
end