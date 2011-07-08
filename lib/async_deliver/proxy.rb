# coding: UTF-8

module Resque::Plugins::AsyncDeliver
  class Proxy
    def initialize(klass)
      @klass = klass
    end

    def method_missing(method_name, *args)
      if Resque.inline?
        @klass.__send__(method_name, *args).deliver
      else
        arguments = [ @klass.name, method_name ]
        args.each do |a|
          if a.class < ::ActiveRecord::Base
            arguments << { :async_deliver_class => a.class.to_s, :async_deliver_id => a.id }
          else
            arguments << a
          end
        end
        Resque.enqueue(MailJob, *arguments)
      end
    end
  end
end
