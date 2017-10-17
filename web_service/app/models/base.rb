class Base
  attr_reader :reply_queue, :lock, :condition, :publisher
  attr_accessor :response, :call_id

  def initialize(reply_queue = '')
    ch = BunnyClient.instance.channel
    @publisher              = ch.default_exchange
    @reply_queue    = ch.queue(reply_queue, :exclusive => true)
    @lock      = Mutex.new
    @condition = ConditionVariable.new

    @reply_queue.subscribe do |_delivery_info, properties, payload|
      if properties[:correlation_id] == call_id
        self.response = payload
        lock.synchronize{ condition.signal }
      end
    end
  end

  private

  def publish!(data = '{}')
    self.call_id = generate_call_id

    publisher.publish(
      data,
      routing_key: self.class::BACKEND_QUEUE,
      correlation_id: call_id,
      reply_to: reply_queue.name
    )
    lock.synchronize { condition.wait(lock) }
    response
  end

  def generate_call_id
    "#{rand}#{rand}#{rand}"
  end
end