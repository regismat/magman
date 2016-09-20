class Delivery < ActiveRecord::Base
  
  belongs_to :item, inverse_of: :deliveries
  belongs_to :provider
  belongs_to :customer
 
  validates :item_id, presence:{message:" non sélectionné"}
  validates :quantity, presence:{message:" ne peut être nul ni vide"},
                       numericality:{message:" ne supporte que des nombres"}, 
                       :allow_nill=>false,
                       :allow_blank=>false
  validates :price, presence:{message:" ne peut être nul ni vide"},
                       numericality:{message:" ne supporte que des nombres"}
  validates :provider_id, presence:{message:" non sélectionné"}
  validates :customer_id, presence:{message:" non sélectionné"}
  validates :reference, presence:{message:" ne peut être vide"}
  validates :date,presence:{message:" non sélectionné"}
  
  
  
  
  def self.to_csv(options={})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |deliver|
        csv << deliver.attributes.values_at(*column_names)
      end
    end
  end
end
