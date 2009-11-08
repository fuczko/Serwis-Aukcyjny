class AuctionController < ApplicationController
  include AuctionHelper
   access_control do
    #allow logged_in
    deny :banned
    deny :not_activated
    allow :admin
    allow anonymous, :to => [:show]
    allow :owner, :of => :auction, :to => [:show, :edit, :update]
  end
  
  def new
    @auction = Auction.new
    @auction.user = current_user
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def index_mine
  end

  def create
  end

  def show
  end

end
