require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :specs do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
  t.rspec_opts = "--format documentation"
end

task default: ['specs']
