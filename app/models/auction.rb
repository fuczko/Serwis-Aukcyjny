class Auction < ActiveRecord::Base
  has_and_belongs_to_many :categories
  
end
