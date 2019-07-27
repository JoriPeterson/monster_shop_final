class User::AddressesController < ApplicationController
	before_action :exclude_admin

	def index
		@user = current_user
		@addresses = @user.addresses
	end

	def new
		@address = Address.new
	end

	def create
		@user = current_user
		@address = @user.addresses.new(address_params)
			if @address.save
				redirect_to user_addresses_path
			else
				generate_flash(@address)
				render :new
			end
	end

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		if @address.update(address_params)
			@address.reload
			redirect_to user_addresses_path
		else
			generate_flash(@address)
			render :edit
		end
	end

	def destroy
		address = Address.find(params[:id])
		address.destroy
	  redirect_to user_addresses_path
	end

	private

	def address_params
		params.permit(:name, :address, :city, :state, :zip)
	end
end
