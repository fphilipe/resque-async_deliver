require 'resque'
require 'resque-async_deliver'
require 'action_mailer'
require 'singleton'

module ActiveRecord
  class Base
    include Singleton
    def self.find(id); instance; end
  end
end

class TestUser < ActiveRecord::Base
  def id; 123; end
end

class TestResource < ActiveRecord::Base
  def id; 456; end
end

class TestMailer < ActionMailer::Base
  extend Resque::Plugins::AsyncDeliver::ActionMailerExtension
  def test_message; end
end

def arguments
  [
    TestUser.instance,
    123,
    "a string",
    %q[ an array ],
    { :a => 'hash' },
    TestResource.instance
  ]
end

def serialized_arguments
  [
    { :async_deliver_class => 'TestUser',
      :async_deliver_id    => TestUser.instance.id },
    123,
    "a string",
    %q[ an array ],
    { :a => 'hash' },
    { :async_deliver_class => 'TestResource',
      :async_deliver_id    => TestResource.instance.id }
  ]
end
