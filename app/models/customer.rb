class Customer < ActiveRecord::Base
  has_one :user
  belongs_to :department
  has_many :orders
  has_many :bookings, inverse_of: :customer
  has_many :items, :through=>:bookings
  has_many :deliveries
  
  validates :names,presence:{message:" ne peut être nul"},
                        length:{within:5..30,message:" ne peut contenir moins de 5 caractères"},
                        uniqueness:{message:"est déjà attribué"} 
  
  validates :telephone, presence:{message:" ne peut être nul"},
                        length:{within:10..13,message:" doit avoir entre 10 et 13 caractères"},
                        uniqueness:{message:" déjà attribué"}
  
  validates :department_id, presence:{message:" ne peut être nul"}
  
  validates :email, uniqueness:{message:" déjà attribué"}
end
