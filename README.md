grnds-sso
=========


# Adding SSO to your application.

- copy the sample config(below) to your app at `config/initializers/grnds_sso.rb` (check existing integrations for clearer or DRYer implementations):

```
Rails.application.config.action_dispatch.cookies_serializer = :json

Grnds::Sso.configure do |config|
  config.base_site = Grnds::Service::Urls[:jarvis]
end
```

- Configure your session store to use the GrandRounds session cookie. Add `config/initializers/session_store.rb`:
```
  if Rails.env == 'test' or Rails.env == 'development'
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session_#{Rails.env}", :domain => :all
  elsif Rails.env == 'production'
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session", :domain => ".#{Frick::Application.config.website_domain}"
  else
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session_#{Rails.env}", :domain => ".#{Frick::Application.config.website_domain}"
  end
```

- In your application.rb, set up the cookie secret (and pay attention to your deployment environment variables):
```
    config.website_domain   = 'grandroundshealth.com'
    config.secret_token = ENV['RAILS_COOKIE_SECRET'] || copy_it_yourself_from_tim_or_tp
```

- Make sure you don't also have a secret_token initializer.
