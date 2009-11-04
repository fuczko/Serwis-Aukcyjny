class User < ActiveRecord::Base
  belongs_to :baseUser, :polymorphic => true
  acts_as_authorization_subject
  has_and_belongs_to_many :roles_users
  has_many :roles, :through => :roles_users
  
  acts_as_authentic do |c|
   #c.my_config_option = my_value
   c.logged_in_timeout(nil)
   c.openid_required_fields = [:login, :email]
 end
 
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end  
 
end
