module Grnds
  module Sso
    module Jwt
      HEADER = 'Authorization'.freeze
      COOKIE = 'user_auth0_token'.freeze

      module Subject
        SUBJECT_CLAIM = :sub
        UID_CLAIM = :'https://grandrounds.com/claims/uid'
        TYPES = {
          application: Regexp.new('@clients$'),
          user: Regexp.new('^auth0\|')
        }.freeze

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

            result = Value.new(*parse(token)).freeze
            result if result.valid?
          end

          private

          def token_from(request)
            request.headers[HEADER].presence ||
              request.cookies[COOKIE].presence
          end

          def parse(token)
            subject = token.payload[SUBJECT_CLAIM]
            type, _ = TYPES.find{ |_, regex| regex.match? subject }
            id = token.payload[UID_CLAIM]

            [type, id]
          end
        end
      end
    end
  end
end
