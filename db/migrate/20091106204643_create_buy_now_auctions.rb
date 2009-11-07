class CreateBuyNowAuctions < ActiveRecord::Migration
  def self.up
    create_table :buy_now_auctions do |t|
      t.decimal :price, :null => false
      t.integer :numer_of_products, :null =>false, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :buy_now_auctions
  end
end