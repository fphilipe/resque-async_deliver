# coding: UTF-8

module Resque::AsyncDeliver
  class MailJob
    @queue = :mail

    def self.perform(*args)
      mailer = args.shift.constantize
      method_name = args.shift
      arguments = []
      args.each do |a|
        if a.is_a? Hash and
          klass = a['async_deliver_class'] || a[:async_deliver_class] and
          id = a['async_deliver_id'] || a[:async_deliver_id]
          arguments << klass.constantize.find(id)
        else
          arguments << a
        end
      end
      mailer.__send__(method_name, *arguments).deliver
    end
  end
end
