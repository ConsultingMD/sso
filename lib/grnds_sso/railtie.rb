module GrndsSso
  class Railtie < Rails::Railtie
    initializer "grnds_sso.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
