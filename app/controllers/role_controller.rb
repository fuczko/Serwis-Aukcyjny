class RoleController < ApplicationController
  def new
    @role = Role.new
    @role.authorizable_type = nil
    @role.authorizable_id = nil
    @users = User.find(:all)
  end

  def create
    @role = Role.new(params[:role])
    
    begin
      @role.save
      flash[:notice] = "Role created!"
      redirect_back_or_default :root
    rescue
      flash[:notice] = "Error with role creation!"
      redirect_back_or_default :root
    end
  end
  
  def delete
  end

  def edit
  end

  def list
  end

end
