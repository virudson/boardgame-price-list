# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'

gem 'config'
gem 'nokogiri'
# gem 'nori' XML to hash
gem 'rest-client'
gem 'money-rails'
gem 'nori'
gem 'ox'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
