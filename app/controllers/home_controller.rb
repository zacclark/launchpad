class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    redirect_to widgets_path and return if user_signed_in?
  end
  
  def set_current_screen
    current_user.current_screen = params[:screen]
    if current_user.save
      render :text => "true"
    else
      render :text => "false"
    end
  end
  
  def return_from_google
    @widget = Widget.find( params[:state].gsub( "widget-", "" ).to_i )
    @widget.access_code = params[:code]
    if @widget.save
      redirect_to widgets_path
    else
      redirect_to edit_widget_path(@widget)
    end
  end
end