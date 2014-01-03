require 'spec_helper'

describe ActionMailer::Base do
  describe '.async_deliver' do
    it 'returns a proxy for the mailer' do
      proxy = TestMailer.async_deliver

      expect(proxy).to be_a(Resque::Plugins::AsyncDeliver::Proxy)
      expect(proxy.klass).to be(TestMailer)
    end
  end
end
