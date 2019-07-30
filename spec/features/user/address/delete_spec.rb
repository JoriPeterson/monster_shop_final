require 'rails_helper'

RSpec.describe 'Delete Address' do
  describe 'As a user' do
    before :each do
			@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @sal = Merchant.create!(name: 'Sals Salamanders', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '888 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)
			@address_3 = @user.addresses.create!(name: 'Megan', address: '111 Base St', city: 'Denver', state: 'CO', zip: 80218, nickname: 2)
			@address_4 = @user.addresses.create!(name: 'Megan', address: '222 Sycamore St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@order_1 = @user.orders.create!(status: "packaged", address_id: @address_1.id)
			@order_2 = @user.orders.create!(status: "pending", address_id: @address_1.id)
			@order_3 = @user.orders.create!(status: "shipped", address_id: @address_2.id)
			@order_4 = @user.orders.create!(status: "shipped", address_id: @address_3.id)
			@order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: true)
			@order_item_2 = @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2, fulfilled: false)
			@order_item_3 = @order_3.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: true)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click button to delete an address' do
      visit user_addresses_path

			within "#address-#{@address_4.id}" do
				click_button 'Delete Address'
			end

			expect(current_path).to eq(user_addresses_path)
    	expect(page).to have_content("Your address has been successfully deleted")
    end

    describe 'If a address has orders that have been shipped' do
      it 'I do not see a button to delete the address' do

				visit user_addresses_path

				within "#address-#{@address_2.id}" do
					expect(page).to_not have_button('Delete Address')
				end

				within "#address-#{@address_1.id}" do
				 expect(page).to have_button('Delete Address')
				 click_button 'Delete Address'
			 	end

				expect(page).to have_content("That address is currently in use. You still have time to edit your address before your order is shipped!")
      end
    end
  end
end
