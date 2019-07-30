class User::OrdersController < ApplicationController
  before_action :exclude_admin

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
		@address = current_user.addresses.find(@order.address_id)
  end

  def create
		@addresses = current_user.addresses
    order = current_user.orders.new
		order.address_id = params[:post][:my_selection]
		if order.save

      cart.items.each do |item|
        order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price,
          })
			end
    session.delete(:cart)
    flash[:notice] = "Order created successfully!"
    redirect_to '/profile/orders'
		end
  end

	def edit
		@order = current_user.orders.find(params[:id])
			if @order.pending?
				@addresses = current_user.addresses
				@address = Address.new
			else
				render file: 'public/404', status: 404
			end
	end

	def update
		@order = current_user.orders.find(params[:id])
			if @order.pending?
				@order.address_id = params[:patch][:my_selection]
				@order.update(order_params)
				@order.reload
				flash[:notice] = "Address updated successfully!"
				redirect_to "/profile/orders/#{@order.id}"
			end
	end

  def cancel
    order = current_user.orders.find(params[:id])
    order.cancel
    redirect_to "/profile/orders/#{order.id}"
  end

	def new_address
		@user = current_user
		@order = current_user.orders.find(params[:id])
		@addresses = current_user.addresses
			if @order.pending?
				@address = @user.addresses.new(address_params)
				if @address.save
					flash[:notice] = "Your address has been successfully added!"
					redirect_to "/profile/orders/#{@order.id}/edit"
				else
					generate_flash(@address)
					render :edit
				end
			end
	end

	private

	def order_params
		params.permit(:status, :user_id, :address_id)
	end

	def address_params
		params.permit(:nickname, :name, :address, :city, :state, :zip)
	end
end
