module Resque
  module Plugins
    module AsyncDeliver
      module Serializer
        CLASS_KEY = 'async_deliver_class'
        ID_KEY    = 'async_deliver_id'

        def self.serialize(*args)
          mailer = args.shift.to_s
          method_name = args.shift.to_s
          arguments = serialize_collection(args)

          [mailer, method_name, *arguments]
        end

        def self.deserialize(*args)
          mailer = args.shift.constantize
          method_name = args.shift.to_sym
          arguments = deserialize_collection(args)

          [mailer, method_name, *arguments]
        end

        private

        def self.serialize_obj(arg)
          if arg.class.respond_to?(:find) and arg.respond_to?(:id)
            { CLASS_KEY => arg.class.to_s, ID_KEY => arg.id }
          else
            serialize_collection(arg)
          end
        end

        def self.deserialize_obj(arg)
          if arg.is_a?(Hash) and arg.key?(CLASS_KEY) and arg.key?(ID_KEY)
            arg[CLASS_KEY].constantize.find(arg[ID_KEY])
          else
            deserialize_collection(arg)
          end
        end

        def self.serialize_collection(obj)
          if obj.is_a?(Array)
            obj.map { |i| serialize_obj(i) }
          elsif obj.is_a?(Hash)
            Hash[obj.map { |k,v| [serialize_obj(k), serialize_obj(v)] }]
          else
            obj
          end
        end

        def self.deserialize_collection(obj)
          if obj.is_a?(Array)
            obj.map { |i| deserialize_obj(i) }
          elsif obj.is_a?(Hash)
            Hash[obj.map { |k,v| [deserialize_obj(k), deserialize_obj(v)] }]
          else
            obj
          end
        end
      end
    end
  end
end
