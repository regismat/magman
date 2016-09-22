class TableSimples < ActiveRecord::Migration
  def change
    create_table "items", force: :cascade do |t|
      t.string  "name",               null: false
      t.string  "detail"
      t.integer "stock",  default: 0
    end
    
    create_table "departments", force: :cascade do |t|
    t.string "description"
    end
    create_table "providers", force: :cascade do |t|
      t.string "names",     null: false
      t.string "town"
      t.string "telephone"
      t.string "email"
    end
    create_table "roles", force: :cascade do |t|
      t.string "title"
      t.string "description"
    end
    
    create_table "customers", force: :cascade do |t|
      t.string  "names"
      t.string  "telephone"
      t.string  "email"
    end
    
    create_table "users", force: :cascade do |t|
      t.string  "username",        null: false
      t.string  "password_digest"
      t.boolean "status"
    end
    
    create_table "bookings", force: :cascade do |t|
      t.string "quantity"
    end
    
    create_table "deliveries", primary_key: "delivery_order", force: :cascade do |t|
      t.date    "date",                      null: false
      t.integer "quantity",    default: 0,   null: false
      t.float   "price",       default: 0.0, null: false
    end
    
    create_table "orders", force: :cascade do |t|
      t.date    "date"
      t.float   "quantity"
  
    end
    
    say_with_time 'Adding foreign keys' do

      execute 'ALTER TABLE customers ADD COLUMN department_id REFERENCES departments( id )'
      execute 'ALTER TABLE users     ADD COLUMN customer_id   REFERENCES customers(id)'
      execute 'ALTER TABLE users     ADD COLUMN role_id       REFERENCES roles(id)'
      execute 'ALTER TABLE bookings  ADD COLUMN item_id       REFERENCES items(id)'  
      execute 'ALTER TABLE bookings  ADD COLUMN customer_id   REFERENCES customers(id)'  
      execute 'ALTER TABLE deliveries ADD COLUMN item_id      REFERENCES items(id)'  
      execute 'ALTER TABLE deliveries ADD COLUMN provider_id  REFERENCES providers(id)'  
      execute 'ALTER TABLE orders     ADD COLUMN item_id      REFERENCES items(id)'  
      execute 'ALTER TABLE orders     ADD COLUMN customer_id  REFERENCES customers(id)'  
      
      execute("INSERT INTO roles (title) VALUES ('Magasinier')")
      execute("INSERT INTO departments (description) VALUES ('admin')")
      execute("INSERT INTO customers (names,department_id) VALUES ('admin',1)")
      
    end
    
    
  end
end
