class Admin::ItemController < ApplicationController
  layout 'standard'
  def index
    @items = Item.all
  end
  
  def alert
     @items = Item.all
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Article enregistré : #{@item.name}"
      redirect_to :action=>'index'
    else
      flash[:notice] = 'Veiller remplir les champs vide!'
      render :action=>'new'
    end
  end
  
  def item_params
    params.require(:item).permit(:name,:detail,:stock,:unit)
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id]) 
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "Article mis à jour : #{@item.name}"
      redirect_to :action=>'index'
    end
  end

  def delete
    @item = Item.find(params[:id]).destroy
    redirect_to :action=>'index'
    flash[:notice] = 'Article supprimé!'
  end
end
