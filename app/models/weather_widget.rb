class WeatherWidget < Widget
  def self.title
    "Weather"
  end
  
  # set/get location (zip code)
  def location
    serialized_settings[:location]
  end
  
  def location= zip
    serialized_settings[:location] = zip
  end
  
  def forecast
    serialized_current_data[:forecast] = [{:high => nil, :low => nil, :conditions => nil, :weekday => nil, :icon => nil}]
  end
  
  def forecast= data
    raise TypeMismatchError unless data.class == Array
    serialized_current_data[:forecast] = data
  end
  
end

class TypeMismatchError < StandardError; end