# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

task :test do
  puts '===================BOARD TESTING==================='
  ruby 'test/board_test.rb'
  puts '===================CELL TESTING===================='
  ruby 'test/cell_test.rb'
end

task :run do
  ruby 'lib/main.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
