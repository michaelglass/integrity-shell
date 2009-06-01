Gem::Specification.new do |s|
  s.name              = "integrity-shell"
  s.version           = "0.1.0"
  s.date              = "2009-05-28"
  s.summary           = "Shell Script notifier for the Integrity continuous integration server"
  s.description       = "Easily let Integrity run a shell script after builds"
#  s.homepage          = "http://integrityapp.com"
  s.email             = "info@thealmanac.org"
  s.authors           = ["Michael Glass", "Michael Geraci", "Jonah Bloch-Johnson"]
  s.has_rdoc          = false

  s.add_dependency "integrity"

#  s.rubyforge_project = "integrity"

   s.files             = %w[
 README.markdown
 Rakefile
 integrity-shell.gemspec
 lib/integrity/notifier/config.haml
 lib/integrity/notifier/shell.rb
 spec/rcov.opts
 spec/spec.opts
 spec/spec_helper.rb
 spec/lib/integrity/notifier/shell_spec.rb
 spec/lib/integrity/notifier/test_fail
 spec/lib/integrity/notifier/test_pass
 ]
end
