class HomeController < ApplicationController
  def index
  end

  #to be called via ajax
  def check_for_updates
    #client version timestamp
    if params[:timestamp].to_i==ApplicationHelper::last_update_timestamp
      return render nothing: true
    end
    render "lists/_lists_refresh.js.erb"
  end
end
