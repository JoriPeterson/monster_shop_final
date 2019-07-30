class UsersController < ApplicationController
  before_action :require_user, only: :show
  before_action :exclude_admin, only: :show

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

	def new_address
		@user = current_user
		@address = Address.new
	end

	def create_address
		@user = current_user
		@address = @user.addresses.new(address_params)
		if @address.save
			redirect_to profile_path
			flash[:notice] = "Welcome, #{@user.name}!"
		else
			flash[:error] = @address.errors.full_messages.to_sentence
			render :new_address
		end
	end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to address_registration_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def edit_password
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Profile has been updated!'
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

	def address_params
		params.permit(:nickname, :name, :address, :city, :state, :zip)
	end
end
