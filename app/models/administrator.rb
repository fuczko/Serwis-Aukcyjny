class Administrator < ActiveRecord::Base
  has_one :user, :as => :baseUser
end
