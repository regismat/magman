class Operation::OrderController < ApplicationController
  layout 'standard'
  def ord_params
    params.require(:order).permit(:date,:quantity,:item_id,:customer_id)
  end
  def load_data
    @customers=Customer.all
    @items=Item.all
  end
  
  def index
    load_data
    @orders=Order.all
  end
  
  def new
    load_data
    @order = Order.new
  end

  def create
    load_data
    @order = Order.new(ord_params)
    @stock = @order.item.stock-@order.quantity
    if @order.save
      @order.item.update_attribute(:stock,@stock)
      flash[:notice]="Transaction effectuée avec succès!"
      redirect_to :action =>'index'
    else
      
      flash[:notice]="Veiller remplir les champs vides!"
      render :action=>'new'
    end
  end

  def show
    load_data
    @order = Order.find(params[:id])
  end

  def edit
    load_data
    @order = Order.find(params[:id])
  end

  def update
    load_data
    @order = Order.find(params[:id])
    if @order.update_attributes(ord_params)
      flash[:notice]="Transaction mise à jour!"
      redirect_to :action =>'index'
    else 
      load_data
      flash[:notice] = "Veiller completer les champs vides!"
      render :action=>'edit'
    end
  end

  def delete
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:notice]="Suppression réussie!"
    else
      flash[:notice]="Suppression réussie!"
    end
    redirect_to :action=>'index'
  end
end
