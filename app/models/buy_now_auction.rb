class BuyNowAuction < ActiveRecord::Base
  has_one :auction, :as => :aucionlike
  validates_numericality_of :number_of_products, :greater_than => 0   
  validates_presence_of :price
end
