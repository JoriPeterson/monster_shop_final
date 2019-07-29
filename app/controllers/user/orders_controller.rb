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
    order = current_user.orders.new

		order.address_id = params[:post][:my_selection]
		order.save

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

	def edit
		@order = current_user.orders.find(params[:id])
		@addresses = current_user.addresses
		@address = Address.new
	end

  def cancel
    order = current_user.orders.find(params[:id])
    order.cancel
    redirect_to "/profile/orders/#{order.id}"
  end

	private

	def order_params
		params.permit(:status, :user_id, :address_id)
	end
end
