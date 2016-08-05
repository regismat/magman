class Operation::DeliveryController < ApplicationController
  
  layout 'standard'
  
  def index
    load_data
    @deliveries = Delivery.all
  end

  def new
    
    load_data
    @delivery = Delivery.new
  end
  
  def deliv_params
    params.require(:delivery).permit(:date,:quantity,:price,:item_id,:provider_id,:customer_id,:reference)
  end
  
  
  def create
    load_data
    @delivery = Delivery.new(deliv_params)
    @stock = @delivery.item.stock+@delivery.quantity
    @delivery.item.stock = @stock
    
    if @delivery.save
      @delivery.item.update_attribute(:stock,@stock)
      flash[:notice] = "Opération effectuée avec succès!"
      redirect_to :action=>'index'
    else 
      load_data
      flash[:notice] = "Veillez remplir les champs vides"
      render :action=>'new'
    end 
  end

  def show
    load_data
    @delivery = Delivery.find(params[:id])
  end

  def update
    load_data
    @delivery = Delivery.find(params[:id])
    @stock = @delivery.item.stock+@delivery.quantity
    @delivery.item.stock = @stock
    if @delivery.update_attributes(deliv_params)
      @delivery.item.update_attribute(:stock,@stock)
      flash[:notice] = "Informations mises à jour!"
      redirect_to :action => 'index'
    else 
      flash[:notice] = "Veillez remplir les champs vides"
      render :action => 'edit'
    end
    
  end

  def edit
    load_data
    @delivery = Delivery.find(params[:id])
  end

  def delete
    @delivery = Delivery.find(params[:id])
    @stock = @delivery.item.stock-@delivery.quantity
    @delivery.item.stock = @stock
    @delivery.item.update_attribute(:stock,@stock)
    if @delivery.destroy
      flash[:notice] = "Opératon supprimée!"
      redirect_to :action => 'index'
    else 
      flash[:notice] = "Opération avortée!"
      redirect_to :action => 'index'
    end
  end
  
  def load_data
    @items = Item.all
    @providers = Provider.all
    @customers = Customer.all
  end
  
end
