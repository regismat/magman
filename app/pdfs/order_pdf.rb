class OrderPdf < Prawn::Document
  def initialize(article,orders,debut,fin,qte)
 
    super()
    @article = article
    @ord = orders
    @debut = debut
    @fin = fin
    @qte = qte
    header
    text_content
    table_content
    text "          "
    text "Quantité-total : #{@qte} (unité de mesure)", size:14, style: :bold
  end
  
  def header
    image "#{Rails.root}/app/assets/images/logo.jpg", width:125,height:75
  end
  
  def text_content
    y_position = cursor - 15
    
    bounding_box([0, y_position], :width=>270, :height=>75) do
      text "APPLICATION DE GESTION DU MAGASIN"
      text "UCBC MagMan"
      text "Rapport de retrait du #{@debut} au #{@fin}"
      text "Description : #{@article}"
      text "Date d'impression : #{Time.now}"
    end
  end
  
  def table_content
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD','FFFFFF']
     # self.column_widths = [40,300,200]
    end
  end
  
  def product_rows
    [['Article','Demandeur','Date']]+
    @ord.map do |order|
      [order.item.name,order.customer.names,order.date]
    end
  end
  
  
end