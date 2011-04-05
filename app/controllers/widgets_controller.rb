Dir["#{RAILS_ROOT}/app/models/*_widget.rb"].each {|file| require_dependency file}

class WidgetsController < ApplicationController
  def index
    @widgets = current_user.widgets
  end
end
