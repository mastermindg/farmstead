source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in farmstead.gemspec
gemspec

group :development, :test do
  gem "byebug", platform: :mri
end

group :development do
  gem "dotenv", "~> 0.11.1"
  gem "listen", "~> 3.0.5"
  gem "pry"
end