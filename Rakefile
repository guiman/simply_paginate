require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new :spec do |test|
  test.libs = ['lib', 'spec']
  test.verbose = true
  test.test_files = FileList['spec/*_spec.rb']
end
