module Grnds
  module Sso
    module Jwt
      HEADER = 'Authorization'.freeze
      COOKIE = 'user_auth0_token'.freeze

      module Subject
        Value = Struct.new(:type, :id) do
          def valid?
            values.all? &:present?
          end
        end

        class << self
          def call(request)
            request_token = token_from(request)
            return unless request_token.present?

            token = Grnds::Auth0::Token.new(request_token)
            token.verify!

            result = Value.new(token.type, token.uid).freeze
            result if result.valid?
          end

          private

          def token_from(request)
            request.headers[HEADER].presence ||
              request.cookies[COOKIE].presence
          end
        end
      end
    end
  end
end
