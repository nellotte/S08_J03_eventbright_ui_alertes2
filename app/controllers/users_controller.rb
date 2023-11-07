class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user, only: [:show]

  def index 
  end

  def show 
    @user = User.find(params[:id])
    @created_events = @user.events.where(admin_id: @user.id)
  end
  
  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end

end