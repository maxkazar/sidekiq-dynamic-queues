require 'sidekiq/fetch'

module Sidekiq
  module DynamicQueues
    class Fetch < Sidekiq::BasicFetch
      def initialize(options)
        super
        @dynamic_queues = options[:queues]
      end

      # overriding Sidekiq::BasicFetch#queues_cmd
      def queues_cmd
        if @dynamic_queues.grep(/\*/).size == 0
          super
        else
          clean_empty_queues

          queues = expand_queues @dynamic_queues
          queues = @strictly_ordered_queues ? queues : queues.shuffle
          queues << "queue:default" if queues.size == 0
          queues << Sidekiq::Fetcher::TIMEOUT
        end
      end

      private

      def expand_queues(queues)
        real_queues = Sidekiq::Queue.all.map &:name

        queues.map do |queue|
          queue = queue.to_s
          pattern = queue.gsub /\*/, ".*"

          if pattern == queue
            queue
          else
            matches = real_queues.grep(/^#{pattern}$/)
            matches.empty? ? queue : matches
          end
        end.flatten.uniq.collect { |queue| "queue:#{queue}" }.sort
      end

      def clean_empty_queues
        Sidekiq::Queue.all.each do |queue|
          queue.clear if queue.size == 0
        end
      end
    end
  end
end
