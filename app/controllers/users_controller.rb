class UsersController < ApplicationController
  layout 'standard'
  
  def list
    @users = User.all
    
  end
  def show
    
  end
  
  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end
  
   def access_edit
    @user = User.find(params[:id])
    @roles = Role.all
    @customers = Customer.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Modification réussie!"
      redirect_to :action=>:list
    else
      flash[:notice] = "Modification réussie!"
      render :action=>:edit
    end
  end
  
  def access_update
    @customers = Customer.all
    @roles = Role.all
    @user = User.find(params[:id])
    if @user.update_attributes(user_access_params)
      flash[:notice] = "Modification réussie!"
      redirect_to :action=>:list
    else
      flash[:notice] = "Modification réussie!"
      render :action=>:access_edit
    end
  end
  
  
  def user_access_params
    params.require(:user).permit(:role_id,:customer_id)
  end
  
  def new
    @user = User.new
  end
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  
 
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      flash[:notice] = "Identification réussi!"
      redirect_to :controller=>:sessions, :action=>:new
    else
      flash[:notice] = "Message d'erreur: Veillez reprendre le processus."
      
      render "new"
      
    end
  end
  
    def grant
      @users = User.all.where(customer_id:nil)
    end
end
