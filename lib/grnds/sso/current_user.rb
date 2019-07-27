# frozen_string_literal: true

# typed: strict

module Grnds
  module Sso
    # Representation of the current authenticated user
    class CurrentUser < T::Struct
      const :user_id, String
      const :primary_role, String
      const :first_name, String
      const :last_name, String
      const :customer_name, T.nilable(String)
      const :institution_name, T.nilable(String)
    end
  end
end
