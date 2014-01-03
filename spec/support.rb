require 'resque'
require 'resque/async_deliver'
require 'action_mailer'
require 'singleton'

class Model
  include Singleton
  def self.find(id); instance; end
end

class TestUser < Model
  def id; 123; end
end

class TestResource < Model
  def id; 456; end
end

class TestMailer < ActionMailer::Base
  extend Resque::Plugins::AsyncDeliver::ActionMailerExtension
  def test_message; end
end
