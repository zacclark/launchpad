class DataRunner::Bus < DataRunner::Base
  
  def update
    stop = @widget.stop_id # tenino & manhattan
    line = @widget.line
    
    # Ordering:
    # - We need the stop info first, which we'll get via the stop_id
    # - Then we get a list of all the "trips" a certain bus line (like SKIP or
    #   225) takes.
    # - Then, we can use the stop info and the trips to get a list of stop
    #   times from the stop_times.txt file.
    
    if @widget.serialized_current_data[:saved_stop_id] == stop && @widget.serialized_current_data[:saved_line] == line
      puts "Relevant data still stored."
    else
      puts "Current data does not match stop setting, re-mining."
      stop_info = get_stop_info(stop)
      trips = get_trips(line)
      stop_times = get_stop_times(stop_info, trips)
      @widget.serialized_current_data[:stop_times_raw] = stop_times
      @widget.serialized_current_data[:stop_info] = stop_info
      @widget.serialized_current_data[:saved_stop_id] = stop
      @widget.serialized_current_data[:saved_line] = line
      @widget.save
    end
  end
  
  private
  
  def self.possible_widgets
    [BusWidget]
  end
  
  # format : stop_id,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type
  def get_stop_info(stop_id)
    f = File.open("lib/rtd-data/stops.txt")
    f.each_line do |line|
      return line.split(",") if line.split(",").first == stop_id
    end
    f.close
  
    nil
  end
  
  # format : route_id,service_id,trip_id,trip_headsign,direction_id,block_id,shape_id
  def get_trips(route)
    trips = []
    
    f = File.open("lib/rtd-data/trips.txt")
    f.each_line do |line|
      line_as_array = line.split(",")
      trips << line_as_array if line_as_array.first == route
    end
    f.close
    
    return trips
  end
  
  # format : trip_id,arrival_time, departure_time,stop_id,stop_sequence,stop_headsign,pickup_type,drop_off_type,shape_dist_traveled
  def get_stop_times(stop,trips)
    trip_ids = trips.collect{|t| t[2]}
    stop_times = []
    
    f = File.open("lib/rtd-data/stop_times.txt")
    f.each_line do |line|
      line_as_array = line.split(",")
      stop_times << line_as_array if trip_ids.include?(line_as_array[0]) && stop[0] == line_as_array[3]
    end
    f.close
    
    return stop_times
  end
  
end

class TypeMismatchError < StandardError; end