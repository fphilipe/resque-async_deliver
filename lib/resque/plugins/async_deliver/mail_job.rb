module Resque
  module Plugins
    module AsyncDeliver
      class MailJob
        @queue = :mail

        def self.perform(*args)
          mailer, *invocation_args = Serializer.deserialize(*args)
          mailer.send(*invocation_args).deliver
        end
      end
    end
  end
end
