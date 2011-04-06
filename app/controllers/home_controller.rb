class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    redirect_to widgets_path and return if user_signed_in?
  end
end