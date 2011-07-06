# coding: UTF-8

require 'spec_helper'

describe Resque::Plugins::AsyncDeliver do
  it 'should extend ActionMailer with Resque::Plugins::AsyncDeliver::ActionMailerExtension' do
    ActionMailer::Base.should respond_to :async_deliver
  end

  it 'should comply to the Resque plugin guidelines' do
    expect { Resque::Plugin.lint(Resque::Plugins::AsyncDeliver) }.to_not raise_error
  end
end
