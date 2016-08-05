class Admin::CustomerController < ApplicationController
  layout 'standard'
  def index
   
    @departments = Department.all
    @customers = Customer.all
  end
  
  def show
     @customer = Customer.find(params[:id])
     @departments = Department.all
  end
  
  def new
    @departments = Department.all
    @customer = Customer.new
  end

  def create
    @departments = Department.all
    @customer = Customer.new(cust_params)
    if @customer.save
      flash[:notice] = "#{@customer.names} a été ajouté dans la base des données"
      redirect_to :action=>'index'
    else
      flash[:notice] = "Veillez remplir les champs vides avant de continuer."
      render :action=>'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    @departments = Department.all
  end

  def update
    @departments = Department.all
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(cust_params)
      flash[:notice] = "Les informations de #{@customer.names} ont été modifiées dans la base des données"
      redirect_to :action=>'index'
    else
      flash[:notice] = "Veillez remplir les champs vides avant de continuer."
      render :action=>'edit'
    end
  end

  def delete
    
    @customer=Customer.find(params[:id]).destroy
    flash[:notice] = "Informations supprimées!"
    redirect_to :action=>'index'
  end
  
  def load
    
    @customers = Customer.all
    @department = Department.all
  end
  
  def cust_params
    params.require(:customer).permit(:names,:telephone,:email,:department_id)
  end
end
