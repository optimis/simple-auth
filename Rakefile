require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "simple-auth"
    gem.summary = %Q{Simple shared authentication API}
    gem.description = %Q{Provides a simple API to authenticate with a rails application}
    gem.email = ["uchouhan@optimiscorp.com", "joshsmoore@gmail.com"]
    gem.homepage = "http://github.com/uchouhan/simple-auth"
    gem.authors = ["Umang Chouhan"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency 'yajl-ruby', '>= 0'
    gem.add_dependency 'rest-client', '>= 0'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
