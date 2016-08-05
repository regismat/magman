class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.column :item_id, :integer
      t.column :cart_id, :integer
      t.column :amount, :float
      t.column :created_at, :datetime

      t.timestamps null: false
    end
  end
  
  def self.down
    drop_table :cart_items
  end
end

