require 'sidekiq'
require 'celluloid'
require 'sidekiq/dynamic_queues/version'
require 'sidekiq/dynamic_queues/fetch'

Sidekiq.configure_server do |config|
  config.options[:fetch] = Sidekiq::DynamicQueues::Fetch
end
