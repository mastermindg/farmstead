require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "RSpec Test and Release Gem"
task :released do
  sh "rake spec"
  sh "rake release"
end

task :default => :spec