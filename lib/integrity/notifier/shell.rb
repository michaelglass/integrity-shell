require 'integrity'
module Integrity
  class Notifier
    class Shell < Notifier::Base
      attr_reader :pass_script, :fail_script
      
      def self.to_haml
        File.read(File.dirname(__FILE__) + "/config.haml")
      end
    
      def initialize(commit, config={})
        @pass_script = config["pass_script"]
        @fail_script = config["fail_script"]
        super(commit, config) # sets @config and @commit
      end
      
      def deliver!
        #we have access to commit and to config
        if @commit.failed?
          `#{fail_script}`
        else
          `#{pass_script}`
        end
      end
    end
    register Shell
  end
end