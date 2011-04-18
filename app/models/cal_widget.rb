class CalWidget < Widget
  def self.title
    "Calendar"
  end
  
  def self.view
    "widgets/calendar"
  end
  
  def access_code= code
    serialized_settings[:access_code] = code
  end
  
  def access_code
    serialized_settings[:access_code]
  end
  
  def access_token= token
    serialized_settings[:access_token] = token
  end
  
  def access_token
    serialized_settings[:access_token]
  end
  
  def refresh_token= token
    serialized_settings[:refresh_token] = token
  end
  
  def refresh_token
    serialized_settings[:refresh_token]
  end
  
  def timed_events
    serialized_current_data[:timed_events] #[{:title, :start_time, :end_time}]
  end
  
  def timed_events= data
    raise TypeMismatchError unless data.class == Array
    serialized_current_data[:timed_events] = data 
  end
  
  def all_day_events
    serialized_current_data[:all_day_events] #[{:title}]
  end
  
  def all_day_events= data
    raise TypeMismatchError unless data.class == Array
    serialized_current_data[:all_day_events] = data
  end
  
  def available_settings
    [:access_code, :access_token, :refresh_token]
  end
end

class TypeMismatchError < StandardError; end