require 'spec_helper'

describe Resque::Plugins::AsyncDeliver::Proxy do
  let(:proxy) { described_class.new(TestMailer) }

  context 'when calling a method on it' do
    it 'enqueues a MailJob' do
      allow(Resque).to receive(:enqueue)

      proxy.test_message('hello', 'world')

      expect(Resque).to have_received(:enqueue).with(
        Resque::Plugins::AsyncDeliver::MailJob,
        'TestMailer',
        'test_message',
        'hello',
        'world'
      )
    end

    context 'when Resque.inline? is true' do
      it 'delivers the mail without queuing' do
        message = double(deliver: true)
        allow(TestMailer).to receive(:test_message) { message }

        begin
          Resque.inline = true
          proxy.test_message
        rescue => e
          Resque.inline = false
          raise e
        end

        expect(message).to have_received(:deliver)
      end
    end
  end
end
