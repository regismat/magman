class Admin::DepartmentController < ApplicationController
  layout 'standard'
  def index
    @department = Department.all
  end

  def show
    dep
  end

  def new
    @department = Department.new
  end

  def create
    dep_params
    @department = Department.new(dep_params)
    if @department.save
      flash[:notice] = "Le département #{@department.description} a été ajouté."
      redirect_to :action=>'index'
    else 
      flash[:notice] = "Veillez saisir le nom du département avant d'enregistrer."
      render :action=>'new'
    end
  end

  def edit
    dep
  end

  def update
    @department = Department.find(params[:id])
    
    if @department.update_attributes(dep_params)
      flash[:notice] = 'Le nom du département a été modifié.'
      redirect_to :action =>'index'
    else
      flash[:notice]='Veillez completer les champs vides pour valider la modification.'
      render :action => 'edit'
    end
  end

  def delete
    dep
    @department.destroy
    flash[:notice]='Département supprimé de la base des données!'
    redirect_to :action=>'index'
    
    
  end
  
  def dep
    @department = Department.find(params[:id])
  end
  
  def dep_params
    params.require(:department).permit(:description)
  end
end
