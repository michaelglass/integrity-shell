require 'integrity'
module Integrity
  class Notifier
    class Shell < Notifier::Base
      def self.to_haml
        def self.to_haml
          File.read(File.dirname(__FILE__) + "/config.haml")
        end
        def deliver!
          raise NotImplementedError, "you need to implement this method in your notifier"
        end
        
      end
    end
  end
end