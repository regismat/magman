class CatalogController < ApplicationController
  #before_filter :initialize_cart
  layout 'standard'
  def show
     id =  session[:user_id]
    
    #@cust = @user.customer
    @user = User.find(id)
    
    @item = Item.find(params[:id])
    
  end

  def index
    #sort_by = params[:sort_by]
    #@item_pages, @items = paginate :items, :order => "items.name", :per_page => 10
    @items = Item.all
    @id =  session[:user_id]
       
    @user = User.find(@id)
    @books=@user.customer.bookings
  end

  def search
  end
end
