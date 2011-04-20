class CalWidget < Widget
  def self.title
    "Calendar"
  end
  
  def self.view
    "widgets/calendar"
  end
  
  def self.data_runner
    DataRunner::Calendar
  end
  
  def access_code= code
    serialized_settings[:access_code] = code
  end
  
  def access_code
    serialized_settings[:access_code]
  end
  
  before_save :grant_token_from_auth_code
  def grant_token_from_auth_code
    return unless self.access_code and self.refresh_token == nil
    return if self.access_token and self.refresh_token != nil
    runner = self.class.data_runner.new(self)
    data =  RestClient.post runner.google_path,
    	        :code => self.access_code,
    	        :client_id => runner.client_id,
    	        :client_secret => runner.client_secret,
    	        :redirect_uri => runner.redirect_url,
    	        :grant_type => 'authorization_code'

    if data.code == 200
      parsed = JSON.parse(data)

      self.access_token = parsed['access_token']
      self.refresh_token = parsed['refresh_token']
      self.needs_to_reauth = false
      self.save
    else
      return false
    end
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
    serialized_current_data[:timed_events] || [] #[{:title, :start_time, :end_time}]
  end
  
  def timed_events= data
    raise TypeMismatchError unless data.class == Array
    
    # calculations for positioning the event on the calendar
    data.each do |entry|
      entry[:top_position] = 
      entry[:height]
    end
    
    serialized_current_data[:timed_events] = data 
  end
  
  def needs_to_reauth= bool
    serialized_current_data[:needs_to_reauth] = bool
  end
  
  def needs_to_reauth
    serialized_current_data[:needs_to_reauth]
  end
  
  def all_day_events
    serialized_current_data[:all_day_events] || [] #[{:title}]
  end
  
  def all_day_events= data
    raise TypeMismatchError unless data.class == Array
    serialized_current_data[:all_day_events] = data
  end
  
  def available_settings
    []
  end
  
  def special_settings
    true
  end
end

class TypeMismatchError < StandardError; end