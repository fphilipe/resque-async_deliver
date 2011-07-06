# coding: UTF-8

require 'rails'

module Resque::AsyncDeliver
  class Railtie < Rails::Railtie
    initializer :after_initialize do
      ActiveSupport.on_load(:action_mailer) do
        Resque::AsyncDeliver.initialize
      end
    end
  end
end
