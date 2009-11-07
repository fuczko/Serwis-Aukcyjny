class CreateRoleUsers < ActiveRecord::Migration
  def self.up
    create_table :role_users, :id => false do |t|
      t.references :role, :user, :null => false
      t.timestamps
    end
     execute "ALTER TABLE role_users ADD CONSTRAINT fk_role_user_1 FOREIGN KEY (user_id) REFERENCES users"
     execute "ALTER TABLE role_users ADD CONSTRAINT fk_role_user_2 FOREIGN KEY (role_id) REFERENCES roles"
  end

  def self.down
    execute "ALTER TABLE role_users DROP CONSTRAINT fk_role_user_1"
    execute "ALTER TABLE role_users DROP CONSTRAINT fk_role_user_2"
    drop_table :role_users
  end
end
