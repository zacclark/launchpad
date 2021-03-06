class DataRunner::Calendar < DataRunner::Base
  
  def update
    calendars = get_calendars()
    
    #if calendars returned an array, we either have calendars
    #to get info about; otherwise we need to reauth with Google
    if (calendars)
      save_event_data(calendars, @widget.access_token)
    end
  end
  
  
  def initialize(widget)
    super(widget)
    @google_path   = 'https://accounts.google.com/o/oauth2/token'
    @client_id     = '73940937617.apps.googleusercontent.com'
    @client_secret = 'ANX1uCUyFeMDMop7Ts6Zc11P'
    # @redirect_url  = 'http://localhost:3001/api/return_from_google'
    @redirect_url  = 'http://oolaunchpad.heroku.com/api/return_from_google'
    @google_cal_path = 'https://www.google.com/calendar/feeds/default/owncalendars/full'
  end
  
  attr_reader :google_path, :client_id, :client_secret, :redirect_url, :google_cal_path
  
  private
  
  def self.possible_widgets
    [CalWidget]
  end
  
  def get_calendars()
    begin
      # don't even try if we know we need to reauth with Google
      if @widget.needs_to_reauth
        return
      end
      access_token = @widget.access_token
      calendar_data = RestClient.get @google_cal_path + "?oauth_token=#{access_token}"
    rescue RestClient::Unauthorized #401 means we need to grant from refresh_token (if it exists)
      if @widget.refresh_token != nil
        grant_token_from_refresh_token(@widget.refresh_token)
        retry
      else
        @widget.needs_to_reauth = true
        @widget.save
        return
      end
    end

    if calendar_data.code == 200
      doc = REXML::Document.new calendar_data

      calendars = []

      doc.elements.each("*/entry") do |elem|
        calendars << {:title => elem.elements["title"].text.to_s, 
                      :path => URI.parse(elem.elements["content"].attributes["src"]).path,
                      :timezone => elem.elements["gCal:timezone"].attributes["value"]}
      end
    end

    return calendars
  end
  
  # call this to grant a new access_token when a 401 is
  # given from a previous access code
  def grant_token_from_refresh_token(refresh_token)
    return unless refresh_token != nil  
    begin
      data = RestClient.post @google_path,
                :client_id => @client_id,
                :client_secret => @client_secret,
                :refresh_token => refresh_token,
                :grant_type => 'refresh_token'
    rescue RestClient::BadRequest
      @widget.needs_to_reauth = true
      @widget.save
      return
    end
    
    parsed = JSON.parse(data)
    
    @widget.access_token = parsed['access_token']
    @widget.refresh_token = parsed['refresh_token']
    @widget.save
    
  end
  
  def save_event_data(calendars, access_token)
    all_day = []
    timed = []
    
    calendars.each do |cal|
      path = 'https://www.google.com' + cal[:path] + "?oauth_token=#{access_token}"

      #calculate time-zone offset for path request
      offset = Time.now.in_time_zone(cal[:timezone]).to_s
      offset = '-' + offset.split('-')[3]
      offset = offset.insert 3, ':'

      today = Time.new
      path += "&start-min=#{today.strftime("%Y-%m-%d")}T01:00:00#{offset}"
      path += "&start-max=#{today.strftime("%Y-%m-%d")}T23:59:59#{offset}"
      path += "&singleevents=true"
      path += "&orderby=starttime"
      path += "&sortorder=a"

      data = RestClient.get path
    
      if data.code == 200
        doc = REXML::Document.new data

        doc.elements.each("*/entry") do |elem|
          name = elem.elements["title"].text.to_s
          start_time = elem.elements["gd:when"].attributes["startTime"].to_s
          fullday = false
          if start_time.length == 10
            fullday = true
          end

          start_time = DateTime.parse(start_time)
          end_time = DateTime.parse(elem.elements["gd:when"].attributes["endTime"].to_s)

          if fullday
            all_day << {:title => name}
          else
            timed << {
              :title => name,
              :start_time => start_time,
              :end_time => end_time
            }
          end
        end
      end
    end
    @widget.timed_events = timed
    @widget.all_day_events = all_day
    @widget.save
  end
end

class TypeMismatchError < StandardError; end