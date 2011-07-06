# coding: UTF-8

module Resque::AsyncDeliver
  class Proxy
    def initialize(klass)
      @klass = klass.name
    end

    def method_missing(method, *args)
      arguments = [ @klass, method ]
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
