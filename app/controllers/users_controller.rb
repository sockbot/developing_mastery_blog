class UsersController < ApplicationController
  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    
    @user.email.downcase!
    
    if @user.save
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash.now.alert = "Couldn't create account. Try again"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
