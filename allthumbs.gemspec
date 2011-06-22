$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'allthumbs/version'

include_files = ["README*", "LICENSE", "Rakefile", "init.rb", "{lib,tasks,test}/**/*"].map do |glob|
  Dir[glob]
end.flatten
exclude_files = ["test/debug.log", "test/doc", "test/doc/*", "test/pkg", "test/pkg/*", "test/tmp", "test/tmp/*"].map do |glob|
  Dir[glob]
end.flatten

spec = Gem::Specification.new do |s|
  s.name              = "allthumbs"
  s.summary           = "Generate single image from tons of thumbails"
  s.version           = Allthumbs::VERSION
  s.author            = "John Bresnik"
  s.email             = "jbresnik@barbariangroup.com"
  s.homepage          = "https://github.com/brez/allthumbs"
  s.description       = "Generate single image from tons of thumbails"
  s.platform          = Gem::Platform::RUBY
  s.files             = include_files - exclude_files
  s.require_path      = "lib"
  s.test_files        = Dir["test/**/test_*.rb"]
  s.has_rdoc          = true
  s.extra_rdoc_files  = Dir["README*"]
  s.rdoc_options << '--line-numbers' << '--inline-source'
  s.requirements << "ImageMagick"
  s.add_development_dependency 'shoulda'
end
