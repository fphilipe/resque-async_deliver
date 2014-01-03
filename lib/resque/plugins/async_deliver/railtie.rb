module Resque
  module Plugins
    module AsyncDeliver
      class Railtie < Rails::Railtie
        initializer :after_initialize do
          ActiveSupport.on_load(:action_mailer) do
            Resque::Plugins::AsyncDeliver.initialize
          end
        end
      end
    end
  end
end
