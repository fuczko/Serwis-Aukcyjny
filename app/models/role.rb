class Role < ActiveRecord::Base
  acts_as_authorization_role
  acts_as_authorization_object
  has_and_belongs_to_many :roles_users
  has_many :users, :through => :roles_users
  before_save :de_capitalize_name
  before_update :de_capitalize_name
  
  def de_capitalize_name
    self.name = self.name.downcase
  end
  
  
end
