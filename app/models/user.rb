class User < ActiveRecord::Base
  #belongs_to :baseUser, :polymorphic => true
  acts_as_authorization_subject
  acts_as_authorization_object
  #has_and_belongs_to_many :roles#_users
  has_many :roles_users 
  has_many :roles, :through => :roles_users
  has_many :auctions
  validates_presence_of :login, :email
  validates_uniqueness_of :login, :message => "Istnieje użytkownik o takiej nazwie"
  validates_uniqueness_of :email, :message => "Istnieje użytkownik o takim e-mailu"
  before_save :assign_roles
  
  def assign_roles
      if(new_record?)
        has_role!(:owner, @user);
        has_role!(:not_activated);
      end
  end
  def ban
    has_role!(:banned)
    #TODO dodaj wyslanie e-maila
  end
  
  def banned?
    has_role?(:banned)
  end
  
  def unban
    has_no_role!(:banned)
    #TODO dodaj wyslanie e-maila
  end
  
  acts_as_authentic do |c|
   #c.my_config_option = my_value
   c.logged_in_timeout(10)
   #TODO sprawdz czy ten timeout dziala
   #c.openid_required_fields = [:login, :email]
 end
  
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end  
  
  def activate! token
    if(token == self.single_access_token)
      reset_single_access_token!
      has_no_role!(:not_activated)
      self.save
    else
      raise "Podany token jest niezgodny z tokenem użytkownika"
    end
  end
  
  def is_admin?
    self.roles.map {|t| t.name.downcase}.include?("admin")
  end
end