class BusWidget < Widget
  def self.title
    "Bus"
  end
  
  def self.view
    "widgets/bus"
  end
  
  def stop_id= id
    serialized_settings[:stop_id] = id
  end
  
  def stop_id
    serialized_settings[:stop_id]
  end
  
  def available_settings
    [:stop_id]
  end
end