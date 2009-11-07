class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  access_control do
    #allow logged_in
    allow :admin
    allow anonymous, :to => [:activate, :new, :create]
    allow :owner, :of => :user, :to => [:show, :edit, :update]
    end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "Account registered!"
      @user.has_role!(:owner, @user);
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
   # allow :admin
   # allow :owner, :of => :user
   if(params[:id])
    @user = User.find(params[:id])
   else
      @user = @current_user
   end
  end
  
  def index
    @users = User.find(:all)  
  end
  
  def activate  
    #postac urla wysyłanego użyszkodnikowi powinna być postaci 
    #www.adres.com/users/activate?[id]=<id_użyszkodnika>&[token]=<perishable_token_użytkownika>
    #UWAGA ! nawiasy kwadratowe wokół id i token są KONIECZNE !
      if(!params[:id])
        flash[:notice] = "Podany url aktywacyjny jest nieprawidłowy" 
        redirect_to :root
        
      else
        @user = User.find(params[:id])
          
        if(params[:token] == @user.perishable_token)
          @user.activated = true;
          @user.save
          flash[:notice] = "Konto zostało zaktywowane !"
          redirect_to :root
        else
          flash[:notice] = "Podany token aktywacyjny jest nieprawidłowy" 
          redirect_to :root
        end
      end
      
  end
  
  def generate_activate_url user
    return "http://" + request.env['HTTP_HOST'] + "/users/activate?[id]="+user.id.to_s() +"&[token]=" + user.perishable_token
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    params[:user][:login] = @user.login  # zapewnienie, żeby użyszkodnik nie zmienił sobie loginu
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
