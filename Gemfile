source 'https://rubygems.org'

gem 'rails', '>= 5.2.1'
gem "railties", ">= 5.2.2.1"
gem "actionview", ">= 5.2.2.1"

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'nokogiri', '~> 1.8.0'
gem 'figaro'
gem 'bootsnap', require: false

gem 'devise', git: 'https://github.com/plataformatec/devise'

gem 'vuejs-rails'
gem 'webpacker'

gem 'browser'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'active_model_serializers'

gem 'delayed_job_active_record' #delayed jobs workers
gem 'daemons' #runner for delayed job

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'byebug', platform: :mri
end

group :development do
  gem "rails-erd", require: false
  gem "better_errors"
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]