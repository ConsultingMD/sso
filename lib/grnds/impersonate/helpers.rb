module Grnds
  module Impersonate
    module HelperMethods
      extend ActiveSupport::Concern

      # Must be loaded before `impersonates :user`
      include Grnds::Impersonate::ImpersonationHelper
      include Grnds::Impersonate::PathHelper
      include Grnds::Impersonate::HelperMethods

      included do
        impersonates :user
      end

      module HelperMethods

        ##
        # So far, defining this appears necessary in our environment because devise
        # doesn't actually define the method till later in the rails bootstrap
        # process, but we need the method defined when we call impersonates.
        def current_user
          super
        end

        ##
        # Fetch the case matching the case_id.
        def fetch_case(case_id = params[:case_id])
          kase = @case
          if kase.nil? && case_id.present?
            kase ||= Case.attempt(:find_by_id, case_id)
            kase ||= Case.attempt(:by_exact_cid, case_id)
          end
          @case ||= kase
        end
        
        ##
        # Returns the service name of the current service (i.e. jarvis, banyan, etc).
        def service_name
          Rails.configuration.service_name.to_sym
        end

        ##
        # Returns the service type of the current case (i.e. consultation, referral, etc).
        def service_type
          params[:service_type].presence || fetch_case.try(:service_type)
        end

        ##
        # Returns the primary user on the specified kase.
        def case_primary(kase)
          user.medical_releaser_only? ? kase.primary : kase.patient
        end
      end
    end
  end
end
