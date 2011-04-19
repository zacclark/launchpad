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
  
  def line= line
    serialized_settings[:line] = line
  end
  
  def line
    serialized_settings[:line]
  end
  
  def available_settings
    [:stop_id, :line]
  end
  
  def stop_times
    serialized_current_data[:stop_times_raw].collect{|str| str[1]}.sort
  rescue NoMethodError
    []
  end
  
  def after_settings_update_action
    # stops save from calling update, because it is hella slow
  end
  
  private
  
  def self.data_runner
    DataRunner::Bus
  end
end