class Widget < ActiveRecord::Base
  belongs_to :user
  
  def view
    raise NonImplementedError
  end
  
  private
  
  @child_widgets = []

  def self.inherited(child)
    @child_widgets << child
    super # important!
  end
  
  def self.available_widgets
    @child_widgets
  end
end

class NonImplementedError < StandardError; end