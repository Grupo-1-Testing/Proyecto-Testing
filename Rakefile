# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

task :test do
  puts '===================BOARD TESTING==================='
  ruby 'test/board_test.rb'
  puts '===================CELL TESTING===================='
  ruby 'test/cell_test.rb'
end

Rake::TestTask.new("test:all") do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['test/**/*_test.rb']
end

task :run do
  ruby 'lib/main.rb'
end
