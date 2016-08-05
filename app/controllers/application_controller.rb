class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  
    
  
  protect_from_forgery with: :exception
  
  def user_session
    if current_user
      id =  session[:user_id]
    
    #@cust = @user.customer
    @user = User.find(id)
    end
  end
  def user_role
    
    if current_user
      id=session[:user_id]
      @us = User.find(id)
      if @us.role_id=1 
        end
  #    @utilisateur ||=User.find(session[:user_id]) if session[:user_id]
      #@utilisateur.role_id = 1
    end
  end
helper_method :user_role
  private
  def initialize_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else        
      @cart = Cart.create
        session[:cart_id] = @cart.id
        end
    end
    
  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
    
  end
  helper_method :current_user
  
  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
end
