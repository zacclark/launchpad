class DataRunner::Base
  
  def initialize(widget)
    raise TypeMismatchError unless self.class.works_with?(widget.class)
    @widget = widget
  end
  
  def update
    raise NonImplementedError
  end
  
  def self.possible_widgets
    []
  end
  
  def self.works_with?(widget)
    if self.possible_widgets.include?(widget)
      return true
    else
      return false
    end
  end

end

class NonImplementedError < StandardError; end
class TypeMismatchError < StandardError; end