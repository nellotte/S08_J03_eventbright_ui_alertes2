class UsersController < ApplicationController

  def index 
  end

  def show 
    @user = User.find(params[:id])
    @created_events = @user.events.where(admin_id: @user.id)
  end
  

end