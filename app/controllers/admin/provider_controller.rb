class Admin::ProviderController < ApplicationController
  layout 'standard'
  before_filter :authorize, :admin_authorize 
  def index
    @providers = Provider.paginate(:page => params[:page], :per_page => 10).order(:names)
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(prov_params)
    if @provider.save
      flash[:notice] = "Fournisseur ajouté: #{@provider.names}"
      redirect_to :action=>'index'
    else
      flash[:notice] = "Veillez remplir les champs vide avant de continuer!"
      render :action=>'new'
    end
    
  end
  
  def prov_params
    params.require(:provider).permit(:names,:town,:telephone,:email)
  end
  
  def show
    @provider = Provider.find(params[:id])  
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(prov_params)
      flash[:notice] = "Informations du fournisseur mises à jour : #{@provider.names}"
      redirect_to :action=>'index'
      
    else
      flash[:notice] = "Veillez remplir les champs vide avant de continuer!"
      render :action=>'edit'
    end
  end

  def delete
    @provider = Provider.find(params[:id]).destroy
    flash[:notice] = "Fournisseur supprimé!"
    redirect_to :action=>'index'
  end
end
