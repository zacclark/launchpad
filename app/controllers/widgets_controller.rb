Dir["#{RAILS_ROOT}/app/models/*_widget.rb"].each {|file| require_dependency file}

class WidgetsController < ApplicationController
  def index
    @widgets = current_user.widgets
    redirect_to new_widget_path and return unless @widgets.length > 0
  end
  
  def new
    @available_widget_types = Widget.available_widgets
  end
end
