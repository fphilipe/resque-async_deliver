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
  extend Resque::AsyncDeliver::ActionMailerExtension
  def test_message; end
end
