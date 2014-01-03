require 'spec_helper'

describe Resque::Plugins::AsyncDeliver::MailJob do
  describe '.perform' do
    it 'instantiates a mail and delivers it' do
      message = double(deliver: true)
      allow(TestMailer).to receive(:test_message) { message }

      described_class.perform(
        'TestMailer',
        :test_message,
        'hello',
        'world'
      )

      expect(TestMailer).to have_received(:test_message).with('hello', 'world')
      expect(message).to have_received(:deliver)
    end
  end
end
