class AuctionsController < ApplicationController
  include AuctionsHelper
  layout "application"
  access_control do
    #allow logged_in
    deny :banned
    deny :not_activated
    allow logged_in, :to => [:new, :create, :index]
    allow :admin
    allow anonymous, :to => [:show]
    allow :owner, :of => :auction, :to => [:show, :edit, :update]
  end
  
  def new
    @auction = Auction.new
    @auction.user = current_user
    #TODO logika dodawania produktu !
  end

  def edit
    if(params[:id])
      @auction = Auction.find(params[:id])
    else
      flash[:notice] = "Error while passing auction ID"
      redirect_to :root
    end
  end

  def destroy
  end

  def index
  end

  def index_mine
  end

  def create
    @auction = Auction.new(params[:auction])
    @auction.user = current_user
    #puts current_user.id
    if @auction.save
      #flash[:notice] = "Account registered!"
      redirect_to "auctions/show/#{params[:auction][:id]}"
      #redirect_back_or_default auctions_url
    else
      #flash[:notice] = "Nie udało się uworzyć aukcji"
      render :action => :new
      @auction.errors.clear
      #redirect_to :root
    end
    #TODO logika dodawania produktu !
  end

  def show
  end

end