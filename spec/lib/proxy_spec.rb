# coding: UTF-8

require 'spec_helper'

describe Resque::Plugins::AsyncDeliver::Proxy do
  describe '#method_missing' do
    let(:proxy) { Resque::Plugins::AsyncDeliver::Proxy.new(TestMailer) }

    context 'when Resque.inline? == false' do
      it 'should enqueue a MailJob in Resque' do
        Resque.expects(:enqueue).with(
          Resque::Plugins::AsyncDeliver::MailJob,
          'TestMailer',
          'test_message',
          *serialized_arguments
        )

        proxy.test_message(*arguments)
      end
    end

    context 'when Resque.inline? == true' do
      before do
        Resque.inline = true
        Resque.expects(:enqueue).never

        message = mock()
        message.expects(:deliver)
        TestMailer.expects(:test_message).with(*arguments).returns(message)
      end

      it 'should deliver the mail instantly' do
        proxy.test_message(*arguments)
      end
    end
  end
end
