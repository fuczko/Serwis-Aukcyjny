class HomeController < ApplicationController
  uses_tiny_mce
  
  def index
   # redirect_to :action => "new", :controller => "user_sessions"
    #@dupa = "kupa"
    
    if !current_user
      @user_session = UserSession.new
    end
    
  
  end
  
end
