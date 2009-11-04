class UpdateUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string,  {:default => " ",:null => false}
    add_column :users, :surname, :string, {:default => " ", :null => false}
    add_column :users, :activated, :boolean, {:default => false} 
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :surname
    remove_column :users, :activated
  end
end