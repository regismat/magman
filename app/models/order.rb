class Order < ActiveRecord::Base
  
  belongs_to :item, inverse_of: :orders
  belongs_to :customer
  
  
  
  
  validates :item_id, presence:{message:" non sélectionné"}
  validates :quantity, presence:{message:" ne peut être nul ni vide"},
                       numericality:{message:" ne supporte que des nombres"},
                       :allow_nill=>false,
                       :allow_blank=>false
  validates :shipper, presence:{message:" non sélectionné"}
  validates :customer_id, presence:{message:" non sélectionné"}
  validates :date,presence:{message:" non sélectionné"}
  
  def self.to_csv(options={})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
  
end
