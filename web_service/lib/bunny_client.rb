class BunnyClient
  include Singleton
  attr_reader :connection, :channel

  def initialize
    host = ENV["RABBIT_HOST"] || 'localhost'
    port = ENV["RABBIT_PORT"] || 5672
    user = ENV["RABBIT_USER"] || 'guest'
    password = ENV["RABBIT_PASSWORD"] || 'guest'

    @connection = Bunny.new("amqp://#{user}:#{password}@#{host}:#{port}")
    @connection.start
    @channel = connection.create_channel
  end
end