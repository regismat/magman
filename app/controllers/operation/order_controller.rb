class Operation::OrderController < ApplicationController
  before_action :authorize, :admin_authorize
  skip_before_action :admin_authorize, only: [:order_delivery_report2,:signature]
  layout 'standard'
  def ord_params
    params.require(:order).permit(:date,:quantity,:item_id,:customer_id,:shipper)
  end
  
  def load_data
    @customers=Customer.all
    @items=Item.all
  end
  
  def order_delivery_report
    load_data
    @orders = Order.paginate(:page=>params[:page],:per_page=>2).where(status:nil)
  end
  
  def order_delivery_report2
    load_data
    @orders = Order.where(["status isNull AND customer_id=:cust",cust: current_user.customer_id])
  end
  
  def signature
    
      @order = Order.find(params[:id])
    if  @order.update_attribute(:status,1)
      redirect_to :action=>:order_delivery_report2
      flash[:notice] = "Retrait confirmé"
    else
     redirect_to :action=>:order_delivery_report2
     flash[:notice] = "Erreur de confirmation!"
    end
  end
  
  def check
    load_data
    @orders = Order.paginate(:page => params[:page], :per_page => 10).order(date: :desc).order(date: :desc).where(["item_id=:it AND date>= :debut AND date<=:fin",it: params[:item_id],debut: params[:debut],fin: params[:fin]])
    @orders_xls = Order.where(["item_id=:it AND date>= :debut AND date<=:fin",it: params[:item_id],debut: params[:debut],fin: params[:fin]]).order(date: :desc)
    @qte = @orders.sum("quantity")
    if params[:item_id]
       @article = Item.find(params[:item_id]).name
    end    
      respond_to do |format|
        format.html
        format.csv { send_data @orders_xls.to_csv}
        format.xls
        format.pdf do 
        pdf=OrderPdf.new(@article,@orders_xls,params[:debut],params[:fin],@qte)
        send_data pdf.render, filename:"Magman_rapport_livraisons_#{Time.now}.pdf",
                              type:"application/pdf",
                              disposition: "inline"

        end
      end
  
  
  end
  
  def index
    load_data
    @orders = Order.paginate(:page => params[:page], :per_page => 10).order(date: :desc)
    @orders_xls = Order.all.order(date: :desc)
    
    respond_to do |format|
      format.html
      format.csv { send_data @orders_xls.to_csv}
      format.xls
    end
  end
  
  def new
    load_data
    @order = Order.new
  end

  def create
    load_data
    @order = Order.new(ord_params)
    
        
    if @order.save
      @stock = @order.item.stock-@order.quantity
      @order.item.update_attribute(:stock,@stock)
      
      if @order.customer_id == current_user.customer_id && current_user.role_id==1    
        @order.update_attribute(:status,1)
      end
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
