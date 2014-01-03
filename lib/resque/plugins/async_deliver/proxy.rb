module Resque
  module Plugins
    module AsyncDeliver
      class Proxy
        attr_reader :klass

        def initialize(klass)
          @klass = klass
        end

        def method_missing(*args)
          if Resque.inline?
            klass.send(*args).deliver
          else
            Resque.enqueue(MailJob, *Serializer.serialize(klass, *args))
          end
        end
      end
    end
  end
end
