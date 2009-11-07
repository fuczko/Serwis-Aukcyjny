require 'Date'
class Auction < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_one :owner, :class_name => 'User' 
  belongs_to :aucionlike, :polymorphic => true
  validates_presence_of :user_id, :start, :end
  validate :start_must_be_after_today
  validate :start_must_be_before_end
  
   def start_must_be_before_end 
     errors.add(:s, "The start of an auction can`t be blank and it must be dated at least 1 day after end") if 
        !start.blank? and (self.start.select_year * 1000 + self.start.select_month * 10 +self.start.select_day) >= (self.end.select_year * 1000 + self.end.select_month * 10 +self.end.select_day) 
   end
  
  def start_must_be_after_today
      errors.add(:s, "The start of an auction can`t be dated in the past") if !start.blank? and start < Date.today
  end
end