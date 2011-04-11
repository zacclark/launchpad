class WeatherWidget < Widget
  def self.title
    "Weather"
  end
  
  def high
    serialized_settings[:high]
  end
  
  def high= tempurature
    serialized_settings[:high] = tempurature
  end
end