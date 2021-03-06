class Widget < ActiveRecord::Base
  belongs_to :user
  serialize :serialized_settings, Hash
  serialize :serialized_current_data, Hash
  
  def after_initialize
    self.serialized_settings ||= {}
    self.serialized_current_data ||= {}
  end
  
  def view
    raise NonImplementedError
  end
  
  def available_settings
    []
  end
  
  def special_settings
    false
  end
  
  def self.data_runner
    DataRunner::Base
  end
  
  def update_data
    self.class.data_runner.new(self).update
  end
  
  def self.title
    raise NonImplementedError
  end
  
  def after_settings_update_action
    update_data
  end
  
  private
  
  @child_widgets = []

  def self.inherited(child)
    @child_widgets << child
    child.instance_eval do
      def model_name
        Widget.model_name
      end
    end
    super # important!
  end
  
  def self.available_widgets
    @child_widgets
  end
end

class NonImplementedError < StandardError; end