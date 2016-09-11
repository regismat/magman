class User < ActiveRecord::Base
  belongs_to :customer
  has_secure_password
  belongs_to :role
  
  

  
  
  validates :username, presence:{message:" ne peut être vide"},
                       uniqueness:{message:" existe déjà"},
                       length:{within:5..8, message: " doit avoir entre 5 et 8 caractères"}
  validates :password, presence:{message:" ne peut être nul"}
                       
end
