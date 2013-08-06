class UsersController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update]

  def show
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "Account created sucessfully!"
      redirect_to user_path(:id => current_user.id)
    else
      flash[:notice] = "There was a problem creating you."
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to current_user
    else
      render :action => :edit
    end
  end

  def destroy
    current_user.destroy
    flash.now[:notify] = "User account destroyed!!!"
    redirect_to root_path
  end
end
