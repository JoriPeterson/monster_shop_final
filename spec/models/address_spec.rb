require 'rails_helper'

RSpec.describe Address do
  describe 'Relationships' do
    it {should belong_to :user }
    it {should have_many :orders }
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

	describe 'Instance Methods' do
		before :each do
			@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '888 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)
			@order_1 = @user.orders.create!(status: "shipped", address_id: @address_1.id)
			@order_2 = @user.orders.create!(status: "pending", address_id: @address_1.id)
			@order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 5, fulfilled: true)
			@order_item_2 = @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 2, fulfilled: true)
			@order_item_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
		end

		it 'display' do
			expect(@address_1.display).to eq("Home: Megan 123 Main St Denver CO 80218")
		end

		it "shipped_orders" do
			expect(@address_1.shipped_orders).to eq([@address_1.id])
			expect(@address_2.shipped_orders).to eq([])
		end

		it "been_shipped_to?" do
			expect(@address_1.been_shipped_to?(@address_1)).to eq(true)
			expect(@address_2.been_shipped_to?(@address_2)).to eq(false)
		end
	end
end
