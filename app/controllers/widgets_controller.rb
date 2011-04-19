Dir["#{RAILS_ROOT}/app/models/*_widget.rb"].each {|file| require_dependency file}

class WidgetsController < ApplicationController
  def index
    @widgets = current_user.widgets
    @widget = @widgets[0]
    redirect_to new_widget_path and return unless @widgets.length > 0
  end
  
  def new
    @available_widget_types = Widget.available_widgets
  end
  
  def show
    render :text => ""
  end
  
  def create
    if Widget.available_widgets.collect {|w| w.to_s}.include?(params[:widget][:type])
      @widget = eval(params[:widget][:type]).new()
    else
      redirect_to new_widget_path and return
    end
    
    current_user.widgets << @widget
  
    redirect_to edit_widget_path(@widget)
  end
  
  def edit
    @widget = Widget.find(params[:id])
  end
  
  def update
    @widget = Widget.find(params[:id])
    if @widget.update_attributes(params[:widget])
      @widget.after_settings_update_action
      redirect_to widgets_path
    else
      redirect_to edit_widget_path(@widget)
    end
  end
  
  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    redirect_to widgets_path
  end
end
