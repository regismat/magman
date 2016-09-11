class Department < ActiveRecord::Base
  has_many :customers
  validates :description, presence:{message:" ne peut être vide"},
                          uniqueness:{message:" existe déjà"}
            
end