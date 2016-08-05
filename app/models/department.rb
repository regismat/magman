class Department < ActiveRecord::Base
  has_many :customers
  validates_presence_of :description, :message=>'Error message'
end