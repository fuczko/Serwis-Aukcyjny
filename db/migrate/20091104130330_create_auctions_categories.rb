class CreateAuctionsCategories < ActiveRecord::Migration
  def self.up
    create_table :auctions_categories, :id => false do |t|
      t.references :auction, :category
    #  t.integer :auction_id, :null=>false
    #  t.integer :category_id, :null=>false
      t.timestamps
    end
    execute "ALTER TABLE auctions_categories ADD CONSTRAINT fk_auctions_categories_1 FOREIGN KEY (auction_id) REFERENCES auctions"
    execute "ALTER TABLE auctions_categories ADD CONSTRAINT fk_auctions_categories_2 FOREIGN KEY (category_id) REFERENCES categories"
  end

  def self.down
    execute "ALTER TABLE auctions_categories DROP CONSTRAINT fk_auctions_categories_1"
    execute "ALTER TABLE auctions_categories DROP CONSTRAINT fk_auctions_categories_2"
    drop_table :auctions_categories
  end
end
