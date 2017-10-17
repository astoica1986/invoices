class Client < Base
  BACKEND_QUEUE = 'backend.clients'

  def self.all!
    new.all!
  end
  
  def all!
    publish!
  end
end
