# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rake/testtask'

task default: %w[lint test]

task :test do
  puts '===================CELL TESTING===================='
  ruby 'test/cell_test.rb'
  puts '===================BOARD TESTING==================='
  ruby 'test/board_test.rb'
end

Rake::TestTask.new('test:all') do |t|
  t.libs = ['lib']
  t.warning = true
  t.test_files = FileList['test/**/*_test.rb']
end

task :run do
  ruby 'lib/main.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
