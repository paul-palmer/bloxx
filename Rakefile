require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

# Default directory to look in is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = %w<--color --format progress>
end

RSpec::Core::RakeTask.new(:console) do |task|
  bundle console
end

task :default => :spec
task :test => :spec
