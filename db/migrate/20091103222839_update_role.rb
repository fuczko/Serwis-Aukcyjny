class UpdateRole < ActiveRecord::Migration
  def self.up
    remove_index :roles, :name
    add_index :roles, [:name, :authorizable_type, :authorizable_id], :unique => true
  end

  def self.down
  end
end
