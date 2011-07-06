# coding: UTF-8

require 'spec_helper'

describe 'requiring resque-async_deliver' do
  it 'should extend ActionMailer with Resque::AsyncDeliver::ActionMailerExtension' do
    ActionMailer::Base.should respond_to :async_deliver
  end
end
