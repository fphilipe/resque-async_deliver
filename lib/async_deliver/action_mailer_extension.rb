# coding: UTF-8

require 'action_mailer'

module Resque::AsyncDeliver
  module ActionMailerExtension
    def async_deliver
      Proxy.new(self)
    end
  end

  def self.initialize
    ActionMailer::Base.send(:extend, ActionMailerExtension)
  end
end
