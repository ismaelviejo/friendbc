require 'open-uri'


class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

# AUTHORIZATION TO USER CONTROLLER

before_action :current_user_must_be_user, only: [:show, :edit, :update, :destroy]
def current_user_must_be_user
  unless current_user == @user
    redirect_to :back, notice: 'You are not authorized for that.'
  end
end


  def index
    @users = User.all

  end

  def show



  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

    respond_to do |format|
     if @user.save
      session[:user_id] = @user.id
      format.html { redirect_to @user, notice: 'User successfully created'}
      format.json { render action: 'show', status: :created, location: @user }
     else
      format.html {render action: 'new'}
      format.json {render json: @user.erros, status: :unprocessable_entity}
     end
    end
  end

  def edit

  end

  def update

    respond_to do |format|
     if @user.update(user_params)
      format.html {redirect_to @user, notice: 'User successfully updated'}
      format.json {head :no_content}
     else
      format.html {render action: 'edit'}
      format.json {render json: @user.erros, status: :unprocessable_entity}
     end
    end

  end

  def destroy

    @user.destroy
    redirect_to users_url
  end

private
# Use callbacks to share common setup or constraints between actions.
def set_user
  @user = User.find_by(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through
def user_params

  params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :facebook_access_token, :facebook_id)

end


end
