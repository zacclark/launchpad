class WeatherWidget < Widget
  DR = DataRunner::Weather
  
  def self.title
    "Weather"
  end
  
  def self.view
    "widgets/weather"
  end
  
  def self.data_runner
    DataRunner::Weather
  end
  
  def zip= code
    serialized_settings[:zip] = code
  end
  
  def zip
    serialized_settings[:zip]
  end
  
  def available_settings
    [:zip]
  end
  
  def forecast
    serialized_current_data[:forecast]# = [{:high => nil, :low => nil, :conditions => nil, :weekday => nil, :icon => nil}]
  end
  
  def forecast= data
    raise TypeMismatchError unless data.class == Array
    serialized_current_data[:forecast] = data
  end
  
  def today
    forecast[0]
  end
  
end
