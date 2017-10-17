class Invoice < Base
  BACKEND_QUEUE = 'backend.invoices'
  
  def self.all!
    new.all!
  end
  
  def all!
    publish!
  end
  
  def self.find_by_client(client_id)
    new.find_by_client(client_id)
  end

  def find_by_client(client_id)
    payload = { client_id: client_id }.to_json
    publish!(payload)
  end
end