require "test/unit"
require "rumbster"
require "message_observers"
require "integrity/notifier/test"

begin
  require "redgreen"
rescue LoadError
end

require File.dirname(__FILE__) + "/../lib/integrity/notifier/email"

class IntegrityEmailTest < Test::Unit::TestCase
  include Integrity::Notifier::Test

  MAIL_SERVER_PORT = 10_000

  def notifier
    "Email"
  end

  def setup
    Net::SMTP.disable_tls

    @server        = Rumbster.new(MAIL_SERVER_PORT)
    @mail_observer = MailMessageObserver.new
    @server.add_observer(@mail_observer)

    @server.start

    setup_database
  end

  def commit(status=:successful)
    Integrity::Commit.gen(status)
  end

  def teardown
    @server.stop
  end

  def test_configuration_form
    assert_form_have_tag "h3", :content => "SMTP Server Configuration"

    assert_form_have_option "to",    "foo@example.org"
    assert_form_have_option "from",  "bar@example.org"
    assert_form_have_option "host",  "foobarhost.biz"
    assert_form_have_option "user",  "foobaruser"
    assert_form_have_option "pass",  "secret"
    # TODO assert_form_have_option "auth",  "plain"
    assert_form_have_option "pass",  "secret"
    assert_form_have_option "domain","localhost"
  end

  def test_it_sends_email_notification
    config = { "host" => "127.0.0.1",
               "port" => MAIL_SERVER_PORT,
               "to"   => "you@example.org",
               "from" => "me@example.org"  }

    successful = commit(:successful)
    failed     = commit(:failed)

    Integrity::Notifier::Email.new(successful, config.dup).deliver!
    Integrity::Notifier::Email.new(failed,     config).deliver!

    mail = @mail_observer.messages.first

    assert_equal ["you@example.org"], mail.destinations
    assert_equal ["me@example.org"],  mail.from
    assert mail.subject.include?("successful")
    assert mail.body.include?(successful.committed_at.to_s)
    assert mail.body.include?(successful.author.name)
    assert mail.body.include?(successful.output)
  end
end
