require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'allthumbs'

desc 'Default: run unit tests.'
task :default => [:clean, :all]

desc 'Test the allthumbs plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'profile'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Start an IRB session with all necessary files required.'
task :shell do |t|
  chdir File.dirname(__FILE__)
  exec 'irb -I lib/ -I lib/allthumbs -r rubygems -r active_record -r tempfile -r init'
end

desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "tmp"
  FileUtils.rm "test/debug.log" rescue nil
  Dir.glob("allthumbs-*.gem").each{|f| FileUtils.rm f }
end

desc 'Build the gemspec.'
task :gemspec do |t|
  exec 'gem build allthumbs.gemspec'
end

desc "Print a list of the files to be put into the gem"
task :manifest => :clean do
  spec.files.each do |file|
    puts file
  end
end

desc "Generate a gemspec file for GitHub"
task :gemspec => :clean do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

desc "Build the gem into the current directory"
task :gem => :gemspec do
  `gem build #{spec.name}.gemspec`
end
