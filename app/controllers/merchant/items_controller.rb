class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.merchant.items
  end

	def show
		@merchant = current_user.merchant
		@item = Item.find(params[:id])
		render '/items/show'
	end

  def new
  end

  def create
    merchant = current_user.merchant
    item = merchant.items.new(item_params)
    if item.save
      redirect_to "/merchant/items"
    else
			flash[:error] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to "/merchant/items"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def change_status
    item = Item.find(params[:id])
    item.update(active: !item.active)
    if item.active?
      flash[:notice] = "#{item.name} is now available for sale"
    else
      flash[:notice] = "#{item.name} is no longer for sale"
    end
    redirect_to '/merchant/items'
  end

  def destroy
    item = Item.find(params[:id])
    if item.orders.empty?
      item.destroy
    else
      flash[:error] = "#{item.name} can not be deleted - it has been ordered!"
    end
    redirect_to '/merchant/items'
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
end
