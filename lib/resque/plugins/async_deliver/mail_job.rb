module Resque::Plugins::AsyncDeliver
  class MailJob
    @queue = :mail

    def self.perform(*args)
      mailer = args.shift.constantize
      method_name = args.shift
      arguments = deserialize_args(args)

      mailer.__send__(method_name, *arguments).deliver
    end

    private

    def self.deserialize_args(args)
      args.map do |arg|
        if arg.is_a?(Hash) and
          klass = arg['async_deliver_class'] and
          id = arg['async_deliver_id']
          klass.constantize.find(id)
        else
          arg
        end
      end
    end
  end
end
