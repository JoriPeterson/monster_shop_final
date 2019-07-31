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
				flash[:error] = @address.errors.full_messages.to_sentence
				render :new
			end
	end

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		if @address.update(address_params)
			flash[:notice] = "Your address has been successfully updated!"
			@address.reload
			redirect_to user_addresses_path
		else
			flash[:error] = @address.errors.full_messages.to_sentence
			render :edit
		end
	end

	def destroy
		address = Address.find(params[:id])
		if address.shipped_orders.include?(address.id)
		elsif
			address.orders.empty?
			address.destroy
			flash[:notice] = "Your address has been successfully deleted"
		else
			flash[:error] = "That address is currently in use. You still have time to edit your address before your order is shipped!"
		end
		redirect_to user_addresses_path
	end

	private

	def address_params
		params.permit(:nickname, :name, :address, :city, :state, :zip)
	end
end
