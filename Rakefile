task :default => :test

task :test do
  ruby "test/integrity_email_test.rb"
end

begin
  require "mg"
  MG.new("integrity-email.gemspec")
rescue LoadError
end
