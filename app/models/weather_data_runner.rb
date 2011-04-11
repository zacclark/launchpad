require 'wunderground-api'

class WeatherDataRunner < DataRunner
  def self.update
    #get array of locations to check then call get_forecast with the array
  end
  
  private
  
  def self.get_forecast(locations)
    locations.each do |i|
      @wg = Wunderground.new(i)
      
      #save these values to database
      @wg.forecast[0]["high"]
      @wg.forecast[0]["low"]
  end
  
end