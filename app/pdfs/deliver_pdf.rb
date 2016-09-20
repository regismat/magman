class DeliverPdf < Prawn::Document
  def initialize(article,deliveries,quantity,debut,fin,qte)
 
    super()
    @article = article
    @del = deliveries
    @quantity = quantity
    @debut = debut
    @fin = fin
    @qte = qte
    header
    text_content
    table_content
    text "          "
    text "Quantité-total : #{@qte} (unité de mesure)", size:14, style: :bold
    text "Coût-total : #{@quantity}$", size:14, style: :bold
  end
  
  def header
    image "#{Rails.root}/app/assets/images/logo.jpg", width:125,height:75
  end
  
  def text_content
    y_position = cursor - 15
    
    bounding_box([0, y_position], :width=>270, :height=>75) do
      text "APPLICATION DE GESTION DU MAGASIN"
      text "UCBC MagMan"
      text "Rapport d'approvisionnement du #{@debut} au #{@fin}"
      text "Date du jour : #{Time.now}"
      text "Description : #{@article}"
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
    [['#','Article','Quantité','P.U($)','P.T($)', 'Date','Acheteur','Fournisseur']]+
    @del.map do |delivery|
      [delivery.reference,delivery.item.name,delivery.quantity,delivery.price,delivery.quantity*delivery.price, delivery.date, delivery.customer.names,delivery.provider.names]
    end
  end
  
  
end