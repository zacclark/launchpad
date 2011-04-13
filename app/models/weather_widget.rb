class WeatherWidget < Widget
  def self.title
    "Weather"
  end
  
  def self.view
    "widgets/weather"
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
end