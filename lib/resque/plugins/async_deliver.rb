require 'resque'

require 'resque/plugins/async_deliver/mail_job'
require 'resque/plugins/async_deliver/serializer'
require 'resque/plugins/async_deliver/proxy'
require 'resque/plugins/async_deliver/action_mailer_extension'

if defined? Rails
  require 'resque/plugins/async_deliver/railtie'
else
  Resque::Plugins::AsyncDeliver.initialize
end
