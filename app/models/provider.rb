class Provider < ActiveRecord::Base
  has_many :deliveries
  

  validates :names,presence:{message:" ne peut être vide"},
                        length:{within:5..30,message:" ne peut contenir moins de 5 caractères"},
                        uniqueness:{message:"est déjà attribué"} 
  validates :telephone, presence:{message:" ne peut être nul"},
                        length:{within:10..13,message:" doit avoir entre 10 et 13 caractères"},
                        uniqueness:{message:" déjà attribué"}
  validates :email, uniqueness:{message:" déjà attribué"}
  validates :town, presence:{message:" ne peut être vide"}

end
