grnds-sso
=========


# Adding SSO to your application.

- copy the sample config(below) to your app at `config/initializers/grnds_sso.rb` (check existing integrations for clearer or DRYer implementations):

```
Rails.application.config.action_dispatch.cookies_serializer = :marshal

Grnds::Sso.configure do |config|
  case Rails.env
  when 'development', 'test'
    config.base_site = 'http://localhost:10001'
  when 'production'
    config.base_site = 'https://www.grandroundshealth.com'
  else
    config.base_site = "https://www.#{Rails.env}.grandroundshealth.com"
  end
  config.sign_in_post_fix = '/app/users/sign_in'
  config.sign_out_post_fix = '/app/users/sign_out'
end
```

- Configure your session store to use the GrandRounds session cookie. Add `config/initializers/session_store.rb`:
```
  if Rails.env == 'test' or Rails.env == 'development'
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session_#{Rails.env}", :domain => :all
  elsif Rails.env == 'production'
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session", :domain => ".#{ConsultingMD::Application.config.website_domain}"
  else
    Frick::Application.config.session_store :cookie_store, key: "_GrandRounds_session_#{Rails.env}", :domain => ".#{ConsultingMD::Application.config.website_domain}"
  end
```

- In your application.rb, set up the cookie secret (and pay attention to your deployment environment variables):
```
    config.website_domain   = 'grandroundshealth.com'
    config.secret_token = ENV['RAILS_COOKIE_SECRET'] || copy_it_yourself_from_tim_or_tp
```

- Make sure you don't also have a secret_token initializer.
