require 'action_mailer'

module Resque
  module Plugins
    module AsyncDeliver
      module ActionMailerExtension
        def async_deliver
          Proxy.new(self)
        end
      end

      def self.initialize
        ActionMailer::Base.send(:extend, ActionMailerExtension)
      end
    end
  end
end
