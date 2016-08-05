class User < ActiveRecord::Base
  belongs_to :customer
  has_secure_password
  belongs_to :role
  
end
