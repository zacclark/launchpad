class DataRunner::Weather < DataRunner::Base
  
  def update
    get_forecast(@widget.zip)
  end
  
  private
  
  def self.possible_widgets
    [WeatherWidget]
  end
  
  def get_forecast(location)
    @wg = Wunderground.new(location)
    forecast = @wg.simple_forecast(4)
    
    data = []
    
    forecast.each do |i|
      data << {
        :high       => i["high"]["fahrenheit"],
        :low        => i["low"]["fahrenheit"],
        :conditions => i["conditions"],
        :weekday    => i["date"]["weekday"],
        :icon       => i["icons"]["icon_set"][9]["icon_url"]
      }
    end 
    
    @widget.forecast = data
    @widget.save
  end
  
end

class TypeMismatchError < StandardError; end