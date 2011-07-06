# coding: UTF-8

require 'spec_helper'

describe Resque::AsyncDeliver::Proxy do
  describe '#method_missing' do
    let(:proxy)    { Resque::AsyncDeliver::Proxy.new(TestMailer) }
    let(:user)     { TestUser.instance }
    let(:resource) { TestResource.instance }

    before do
      Resque.expects(:enqueue).with(
        Resque::AsyncDeliver::MailJob,
        'TestMailer',
        :test_message,
        { :async_deliver_class => 'TestUser',
          :async_deliver_id    => user.id },
          123,
          "a string",
          %q[ an array ],
          { :a => 'hash' },
          { :async_deliver_class => 'TestResource',
            :async_deliver_id    => resource.id }
      )
    end

    it 'should enqueue a MailJob in Resque' do
      proxy.test_message(
        user,
        123,
        "a string",
        %q[ an array ],
        { :a => 'hash' },
        resource
      )
    end
  end
end
