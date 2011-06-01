class UsersController < ApplicationController
  before_filter :no_user, :only => [:new, :create]
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :active_game_redirect, :except => [:new, :create]
  
  def new
    @title = 'Sign Up'
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Account created. Welcome!'
      redirect_to root_path
    else
      @title = 'Sign Up'
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end
  end
  
  def edit
    @title = 'Edit user info'
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'User info updated.'
      redirect_to root_path
    else
      @title = 'Edit user info'
      render 'edit'
    end
  end
  
  private
  
    def no_user
      redirect_to(root_path) if signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
