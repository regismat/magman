class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  
    
  
  protect_from_forgery with: :exception
  
  def user_session
    if current_user
      id =  session[:user_id]
    

    @user = User.find(id)
    end
  end
  def user_role
 
    if current_user
      id=session[:user_id]
      @us = User.find(id)
      if @us.role_id=1 
        end

    end
  end
#helper_method :user_role
  
  def page_name
     return $pg_name
  end
  helper_method :page_name  
  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
    
  end
  helper_method :current_user
  def admin_authorize
      redirect_to bookings_index_path(), alert: "Accès non-autorisé" if admin?
  end
  def authorize
    redirect_to login_url, alert: "Connectez-vous d'abord!" if current_user.nil?
  end
  def admin?
    if current_user
      current_user.role.title!='Magasinier'
    end
  end
  helper_method :admin?  
end