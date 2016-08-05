class BookingsController < ApplicationController
  layout 'standard'
  def index
    @items = Item.all
    @booking = Booking.new
    @id =  session[:user_id]
    @user = User.find(@id)
    
    @customer = @user.customer
    @reserves = @customer.bookings
    
    
    
  end
  
  def list
    @books = Booking.all
    @customers = Customer.all
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
    #params[:customer_id]=@customer.id
    
    if @customer.items.exists?(:id=>params[:item_id])
      flash[:notice] = "cet article est deja reserve!"
      render :action=>'index'
    else
      @booking = Booking.new(booking_params)
       if @booking.save
      
      flash[:notice]="Reservation reussie!"
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
  

end
