class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :null => false

      t.timestamps
    end
    add_index :categories, :name, :unique=> true
  end

  def self.down
    remove_index :categories, :name, :unique=> true
    drop_table :categories
  end
end


