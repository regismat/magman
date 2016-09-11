class Item < ActiveRecord::Base
  
  
  has_many :deliveries, inverse_of: :item
  has_many :orders, inverse_of: :item
  
  has_many :bookings, inverse_of: :item
  has_many :customers, :through => :bookings

  accepts_nested_attributes_for :deliveries, :orders
  
  validates :name, presence:{message:" ne peut être vide"},
                   uniqueness:{message:" existe déjà"}
  validates :detail, presence:{message:" ne peut être vide"}
  validates :stock, presence:{message:" ne peut être vide"}
  validates :unit, presence:{message:" ne peut être vide"}
end
