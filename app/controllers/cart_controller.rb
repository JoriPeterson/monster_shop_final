class CartController < ApplicationController
  before_action :exclude_admin

  def add_item
    item = Item.find(params[:item_id])
    session[:cart] ||= {}
    if cart.limit_reached?(item.id)
      flash[:notice] = "You have all the item's inventory in your cart already!"
    else
      cart.add_item(item.id.to_s)
      session[:cart] = cart.contents
      flash[:notice] = "#{item.name} has been added to your cart!"
    end
    redirect_to items_path
  end

  def show
		@user = current_user
		if @user
			@addresses = @user.addresses
		end
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update_quantity
    if params[:change] == "more"
      cart.add_item(params[:item_id])
    elsif params[:change] == "less"
      cart.less_item(params[:item_id])
      return remove_item if cart.count_of(params[:item_id]) == 0
    end
    session[:cart] = cart.contents
    redirect_to '/cart'
  end

	def edit
		@address = Address.new
	end

	def new_address
		user = current_user
		# @addresses = current_user.addresses
		@address = user.addresses.new(address_params)
			if @address.save
				flash[:notice] = "Your address has been successfully added!"
				redirect_to cart_path
			else
				generate_flash(@address)
				render :show
			end
	end

	private

	def address_params
		params.permit(:nickname, :name, :address, :city, :state, :zip)
	end
end
