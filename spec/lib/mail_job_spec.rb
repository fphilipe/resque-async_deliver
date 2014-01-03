# coding: UTF-8

require 'spec_helper'

describe Resque::Plugins::AsyncDeliver::MailJob do
  describe '.perform' do
    before do
      message = mock()
      message.expects(:deliver)

      TestMailer.expects(:test_message).with(*arguments).returns(message)
    end

    it 'should instantiate a mail and deliver it' do
      Resque::Plugins::AsyncDeliver::MailJob.perform(
        'TestMailer',
        :test_message,
        *serialized_arguments
      )
    end
  end
end
