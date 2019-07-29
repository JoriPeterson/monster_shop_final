class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
		@address = @user.addresses.where(nickname: 0).first
  end
end
