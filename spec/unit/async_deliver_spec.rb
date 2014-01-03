require 'spec_helper'

describe Resque::Plugins::AsyncDeliver do
  it 'complies with the resque plugin guidelines' do
    expect {
      Resque::Plugin.lint(described_class)
    }.not_to raise_error
  end
end
