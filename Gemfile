source "https://rubygems.org"

git_source(:consulting_md) do |repo_name|
  "git@github.com:ConsultingMD/#{repo_name}.git"
end

# gem's dependencies specified in `./grnds-sso.gemspec`
gemspec

gem 'grnds-auth0', consulting_md: 'auth0', branch: 'master'

group :test do
  gem 'rails', '5.2.0', require: %w(action_controller rails)
  gem 'rspec'
end
