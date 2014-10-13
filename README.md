grnds-sso
=========


# Adding SSO to your application.

- copy the sample config(below) to your app at `config/initializers/grnds_sso.rb`

```
Grnds::Sso.configure do |config|
  case Rails.env
  when 'development', 'test'
    config.base_site = 'http://localhost:3000'
  when 'uat'
    config.base_site = 'https://www.uat.grandroundshealth.com'
  when 'production'
    config.base_site = 'https://www.grandroundshealth.com'
  end
  config.sign_in_post_fix = '/app/users/sign_in'
  config.sign_out_post_fix = '/app/users/sign_out'
end
```

Add environment configurations.

