class DataRunner < ActiveRecord::Base
  
  def self.update
    raise NonImplementedError
  end

end

class NonImplementedError < StandardError; end