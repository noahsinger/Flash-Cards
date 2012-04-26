source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'acts_as_list', '~> 0.1.5'
gem 'rest_in_place'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
	gem 'pg'
end

group :development, :test do
	gem 'sqlite3'
	gem "letter_opener"
	gem "turn"
	gem "minitest"
	gem "quiet_assets"
	gem "capybara"
	gem "capybara-webkit" #requires qt library (brew install qt)
	
	gem "guard-minitest", :git => "http://github.com/aspiers/guard-minitest.git"
	gem "ruby-prof"  #for guard-minitest
	
	gem "awesome_print"
	gem "hirb"
end


















