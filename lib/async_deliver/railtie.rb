# coding: UTF-8

require 'rails'

module Resque::Plugins::AsyncDeliver
  class Railtie < Rails::Railtie
    initializer :after_initialize do
      ActiveSupport.on_load(:action_mailer) do
        Resque::Plugins::AsyncDeliver.initialize
      end
    end
  end
end
