class Role < ActiveRecord::Base
  has_many :users
  
  validates :title,presence:{message:" ne peut être vide"},
                        uniqueness:{message:" est déjà attribué"} 
  validates :description, presence:{message:" ne peut être vide"}                  


end
