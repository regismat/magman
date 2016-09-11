class Admin::RoleController < ApplicationController
  layout 'standard'
  before_filter :authorize, :admin_authorize
  def list
    @roles = Role.all
  end
  
  def role_params
    params.require(:role).permit(:title,:description)
  end
  
  def edit
    @role = Role.find(params[:id])  
  end

  def update
    @role = Role.find(params[:id])
    
    if @role.update_attributes(role_params)
      flash[:notice] = 'Role mis à jour!'
      redirect_to action: :list
    else
      render action: :edit
      flash[:notice] = 'Erreur de mise à jour, veillez recommencer.'
    end
  end

  def new
     @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:notice] = 'Enregistrement reussi!'
      redirect_to action: :list
    else
      flash[:notice] = "Erreur d'enregistrement, veillez recommencer."
      render action: :new
    end
    
  end

  def destroy
    @role = Role.find(params[:id])
  end
end
