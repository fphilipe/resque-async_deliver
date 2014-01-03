# coding: UTF-8

require 'spec_helper'

describe 'a class extended with Resque::Plugins::AsyncDeliver::ActionMailerExtension' do
  describe '.async_deliver' do
    before do
      Resque::Plugins::AsyncDeliver::Proxy.expects(:new).with(TestMailer)
    end

    it 'should return a Proxy for the class' do
      TestMailer.async_deliver
    end
  end
end
