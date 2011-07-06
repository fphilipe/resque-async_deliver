# coding: UTF-8

require 'spec_helper'

describe Resque::Plugins::AsyncDeliver::MailJob do
  describe '.perform' do
    let(:user)     { TestUser.instance }
    let(:resource) { TestResource.instance }

    before do
      message = mock()
      message.expects(:deliver)

      TestMailer.expects(:test_message).with(
        user,
        123,
        "a string",
        %q[ an array ],
        { :a => 'hash' },
        resource
      ).returns(message)
    end

    it 'should instantiate a mail and deliver it' do
      Resque::Plugins::AsyncDeliver::MailJob.perform(
        'TestMailer',
        :test_message,
        { :async_deliver_class => 'TestUser',
          :async_deliver_id    => user.id },
        123,
        "a string",
        %q[ an array ],
        { :a => 'hash' },
        { :async_deliver_class => 'TestResource',
          :async_deliver_id    => resource.id })
    end
  end
end
