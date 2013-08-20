class SessionsController < ApplicationController

def new
end

def create
  @user = User.find_by username: params[:username]

  if @user.present? && @user.authentication(params[:password])
    session[:user_id] = @user.id
    redirect_to root_url
  else
    redirect_to new_session_url

end

def destroy
end



end
