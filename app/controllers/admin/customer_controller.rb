class Admin::CustomerController < ApplicationController
  layout 'standard'
  before_action :authorize, :admin_authorize
  skip_before_action :admin_authorize, only: [:show,:edit,:update]
  def index
    @departments = Department.all
    @customers = Customer.paginate(:page=>params[:page], :per_page =>10).order(:names)
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
      flash[:notice] = "#{@customer.names} a été ajouté dans la base des données"
    else
      flash[:notice] = "Veillez remplir les champs vides avant de continuer."
     # redirect_to :action=>'new'
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
      if current_user.role.title=='Magasinier'
        flash[:notice] = "Les informations de #{@customer.names} ont été mises à jour"
        redirect_to :action=>'index'
      else
        flash[:notice] = "Les informations de #{@customer.names} ont été mises à jour"
        redirect_to admin_customer_show_path(:id=>@customer.id) 
      end
      
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
