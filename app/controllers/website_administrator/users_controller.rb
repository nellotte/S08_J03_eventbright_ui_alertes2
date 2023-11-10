class WebsiteAdministrator::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to website_administrator_user_path(@user), notice: 'Utilisateur mis à jour avec succès.'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :is_website_administrator)
  end

end
