module Resque
  module Plugins
    module AsyncDeliver
      class Proxy
        def initialize(klass)
          @klass = klass
        end

        def method_missing(method_name, *args)
          if Resque.inline?
            @klass.__send__(method_name, *args).deliver
          else
            serialization = [ @klass.name, method_name.to_s, *serialize_args(args) ]
            Resque.enqueue(MailJob, *serialization)
          end
        end

        private

        def serialize_args(args)
          args.map do |arg|
            if arg.is_a?(::ActiveRecord::Base)
              {
                'async_deliver_class' => arg.class.to_s,
                'async_deliver_id'    => arg.id
              }
            else
              arg
            end
          end
        end
      end
    end
  end
end
