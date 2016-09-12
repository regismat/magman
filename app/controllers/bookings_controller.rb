class BookingsController < ApplicationController
  layout 'standard'
  before_action :authorize, :admin_authorize
  skip_before_action :admin_authorize, only: [:index,:new,:create,:delete]
  def index
    @items = Item.all
    @booking = Booking.new
    @id =  session[:user_id]
    @user = User.find(@id) 
    @customer = @user.customer
    @reserves = @customer.bookings
     
  end
  
  def list
    @books = Booking.paginate(:page=>params[:page],:per_page=>10)
  end
  
  def alert
    @bookings = Booking.all
  end
  
  def new
    @items = Item.all
    @booking = Booking.new
    @id =  session[:user_id]
    @user = User.find(@id)
    @items = Item.all
    @customer = @user.customer
    
  end
  
  def booking_params
    params.require(:booking).permit(:item_id, :customer_id,:quantity) 
  end
  
  def create
    
    @id =  session[:user_id]
    @user = User.find(@id)
    @items = Item.all
    @customer = @user.customer   
    
    if params[:booking][:item_id].present? && @customer.items.include?(Item.find(params[:booking][:item_id]))
      flash[:notice] = "Une autre réservation de #{Item.find(params[:booking][:item_id]).name} est en attente! Supprimez-la pour continuer."
      redirect_to :action=>'index'
    else
      @booking = Booking.new(booking_params)
       if @booking.save
        flash[:notice]="Reservation réussie!"
        redirect_to :action=>'index'
       else
        flash[:notice]="Erreur d'enregistrement!"
        render :action=>'index'
       end
    end
   end
   
  def edit
    @book = Booking.find(params[:customer_id])
  end
  
  def update
    @book = Booking.find(params[:id])
    if @book.update_attributes
      render partial :"index"
    else
      render partial :"edit"
    end
  end
  
  def delete
    @items = Item.all
    @booking = Booking.new
    @id =  session[:user_id]
    @user = User.find(@id)
    
    @customer = @user.customer
    @reserves = @customer.bookings
    bk = Booking.find(params[:id]).destroy
    flash[:notice]="Suppression reussie!"
    redirect_to :action=>'index'
      
  end
  
  def clear
    @id =  session[:user_id]
    @user = User.find(@id)
    @customer = @user.customer
    @reserves = @customer.bookings
    if @reserves.clear
      flash[:notice] = "Panier de reservations vidé!"
      redirect_to :action=>'index'
    else
      flash[:notice] = "Panier de reservations non-liberé!"
      redirect_to :action=>'index'
    end
  end
 def load_data
   @customers=Customer.all
   @items=Item.all
 end 
  def order
    load_data
    @book = Booking.find(params[:id])
  end
  def ord_params
    params.require(:order).permit(:date,:quantity,:item_id,:customer_id,:shipper)
  end
  def validate
    load_data
    @book = Booking.find(params[:id])
    @order = Order.new(ord_params)
    @stock = @order.item.stock-@order.quantity
    a = params[:customer_id]
    b = params[:shipper]
    if @order.save
      @order.item.update_attribute(:stock,@stock)
      @book.destroy
       
      if @order.customer_id == current_user.customer_id && current_user.role_id==1    
        @order.update_attribute(:status,1)
      end
      flash[:notice]="Transaction effectuée avec succès!"
      redirect_to :action =>'list'
    else
      
      flash[:notice]="Veiller remplir les champs vides!"
      render :action=>'order'
    end
  end

end
