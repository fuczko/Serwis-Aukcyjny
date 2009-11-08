#require 'Date'
class Auction < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :user, :class_name => 'User', :foreign_key => "user_id" 
  belongs_to :aucionlike, :polymorphic => true
  
  before_save :assign_roles
  
  validates_presence_of :user_id, :message => "BŁĄD ! nie da się stworzyć aukcji bez właściciela" 
  validates_presence_of :start, :end
 # validates_presence_of :user
  validate :start_must_be_after_today, :message => "Aukcja musi zacząć się najwcześniej od jutra"
  validate :start_must_be_before_end, :message => "Początek aukcji musi być przed jej końcem"
  validates_numericality_of :minimal_price, :greater_than_or_equal_to => 0
  acts_as_authorization_object
   def start_must_be_before_end 
     errors.add(:s, "The start of an auction can`t be blank and it must be dated at least 1 day before end") if 
        start.blank? or self.start >= self.end #(self.start.year() * 1000 + self.start.month() * 100 +self.start.day()) >= (self.end.year() * 1000 + self.end.month() * 10 +self.end.day()) 
   end
   
   
   
   def assign_roles
    # puts "BLA"
     
     if(new_record?)
       if(self.user)       
       # user = self.user
       # self.user = nil
        user.has_role!(:owner, @auction)
       # self.user = user
       else
        raise "Nie można zachować aukcji bez właściciela"
       end
    end
   end
  
  def start_must_be_after_today
    a = Time.now
      errors.add(:s, "The start of an auction can`t be dated in the past") if !start.blank? and (start.year() * 1000 + start.month() * 100 + start.day() ) < (a.year() * 1000 + a.month() *100 + a.day())
  end
end