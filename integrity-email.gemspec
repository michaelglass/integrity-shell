Gem::Specification.new do |s|
  s.name              = "integrity-email"
  s.version           = "1.0.3"
  s.date              = "2009-04-06"
  s.summary           = "Email notifier for the Integrity continuous integration server"
  s.description       = "Easily let Integrity send emails after each build"
  s.homepage          = "http://integrityapp.com"
  s.email             = "info@integrityapp.com"
  s.authors           = ["Nicolás Sanguinetti", "Simon Rozet"]
  s.has_rdoc          = false

  s.add_dependency "integrity"
  s.add_dependency "sinatra-ditties", [">= 0.0.2"]

  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency "rumbster"
  end

  s.rubyforge_project = "integrity"

  s.files             = %w[
README.markdown
Rakefile
integrity-email.gemspec
lib/integrity/notifier/config.haml
lib/integrity/notifier/email.rb
test/integrity_email_test.rb
]
end
