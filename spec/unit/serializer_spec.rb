require 'spec_helper'
require 'json'

describe Resque::Plugins::AsyncDeliver::Serializer do
  def serialize_and_deserialize(*args)
    serialization = described_class.serialize(*args)
    json = JSON.dump(serialization)
    array = JSON.load(json)

    described_class.deserialize(*array)
  end

  describe '.serialize' do
    it 'returns an array with the serialized arguments' do
      serialization = described_class.serialize(TestMailer, :foo, 'arg')

      expect(serialization).to eq(['TestMailer', 'foo', 'arg'])
    end
  end

  describe '.deserialize' do
    it 'returns an array with the deserialized arguments' do
      deserialization =
        described_class.deserialize('TestMailer', 'foo', 'arg')

      expect(deserialization).to eq([TestMailer, :foo, 'arg'])
    end
  end

  it 'serializes and deserializes basic objects and queryable models' do
    args = [
      TestUser.instance,
      123,
      'a string',
      %q[ an array ],
      { 'a' => 'hash' },
      TestResource.instance
    ]

    deserialization = serialize_and_deserialize(TestMailer, :foo, *args)

    expect(deserialization.shift).to be(TestMailer)
    expect(deserialization.shift).to be(:foo)
    expect(deserialization).to eq(args)
  end

  it 'serializes and deserializes queryable models inside arrays' do
    array = [TestUser.instance]
    deserialization = serialize_and_deserialize(TestMailer, :foo, array)

    expect(deserialization).to eq([TestMailer, :foo, array])
  end

  it 'serializes and deserializes queryable models inside hashes' do
    hash = { 'user' => TestUser.instance }
    deserialization = serialize_and_deserialize(TestMailer, :foo, hash)

    expect(deserialization).to eq([TestMailer, :foo, hash])
  end
end
