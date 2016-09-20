class Operation::DeliveryController < ApplicationController
  before_filter :authorize, :admin_authorize
  layout 'standard'
  
  def check
    #params.require(:delivery).permit(:debut,:fin)
    load_data   
    @deliveries_xls = Delivery.where(["item_id=:it AND date>= :debut AND date<=:fin",it: params[:item_id],debut: params[:debut],fin: params[:fin]]).order(date: :desc) 
    @deliveries = Delivery.paginate(:page => params[:page], :per_page => 10).where(["item_id=:it AND date>= :debut AND date<=:fin",it: params[:item_id],debut: params[:debut],fin: params[:fin]]).order(date: :desc)
    #@deliveries = Delivery.paginate(:page => params[:page], :per_page => 10).where(["item_id=:it AND date>= :debut AND date<=:fin",it: params[:item_id],debut: params[:debut],fin: params[:fin]]).order(date: :desc)
    @quantity = @deliveries.sum("quantity*price")
    @qte = @deliveries.sum("quantity")
    if params[:item_id]
       @article = Item.find(params[:item_id]).name
      
    end
     
      respond_to do |format|
        format.csv { send_data @deliveries_xls.to_csv}
        format.xls
        format.html
        format.pdf do 
        pdf=DeliverPdf.new(@article,@deliveries_xls,@quantity,params[:debut],params[:fin],@qte)
        send_data pdf.render, filename:"Magman_rapport_approvisionnement_#{Time.now}.pdf",
                              type:"application/pdf",
                              disposition: "inline"

        end
      end
  end
  
  def index
    $pg_name = "Livraison"
    load_data
    @deliveries = Delivery.paginate(:page => params[:page], :per_page => 10).order(date: :desc).order(date: :desc)
    @deliveries_xls = Delivery.all.order(date: :desc)
   
    respond_to do |format|
      format.html
      format.csv { send_data @deliveries_xls.to_csv}
      format.xls
    end
  
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
  
    if @delivery.save
      @stock = @delivery.item.stock + @delivery.quantity
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
