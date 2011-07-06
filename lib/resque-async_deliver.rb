# coding: UTF-8

require 'resque'
require 'async_deliver/mail_job'
require 'async_deliver/proxy'
require 'async_deliver/action_mailer_extension'

if defined? Rails
  require 'async_deliver/railtie'
else
  Resque::Plugins::AsyncDeliver.initialize
end
