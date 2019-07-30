require 'rails_helper'

RSpec.describe 'Edit User Address' do
  describe 'As a User' do
    before :each do
			@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '777 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)
			@order_1 = @user.orders.create!(status: "packaged", address_id: @address_1.id)
      @order_2 = @user.orders.create!(status: "pending", address_id: @address_1.id)
			@order_3 = @user.orders.create!(status: "shipped", address_id: @address_1.id)
      @order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

			visit item_path(@ogre)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'

      visit '/cart'

      click_button 'Check Out'
    end

    it 'I can change my address if the order is still pending' do

			visit "/profile/orders/#{@order_2.id}"
      click_button 'Change Address'

      expect(current_path).to eq("/profile/orders/#{@order_2.id}/edit")

			page.select("Work: Megan 777 Market St Denver CO 80218", :from => @addresses)

			click_button "Change Address"

			expect(current_path).to eq("/profile/orders/#{@order_2.id}")
			expect(page).to have_content("#{@address_2.nickname}: #{@address_2.name} #{@address_2.address} #{@address_2.city} #{@address_2.state} #{@address_2.zip}")
		end

		it "Or I can add a new address" do

			visit "/profile/orders/#{@order_2.id}"
      click_button 'Change Address'

      name = 'Jori'
      address = "777 Sheridan Ave"
      city = "Westminster"
      state = 'CO'
      zip = 80021

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'zip', with: zip
      click_button 'New Address'

      expect(current_path).to eq(user_addresses_path)
      expect(page).to have_content("Address: #{address}")
      expect(page).to have_content("City: #{city}")
      expect(page).to have_content("State: #{state}")
      expect(page).to have_content("Zip: #{zip}")
    end

    it 'I can not create an address for a user with an incomplete form' do
      name = 'Jori'

			visit "/profile/orders/#{@order_2.id}"
      click_button 'Change Address'

      fill_in 'Name', with: name
			fill_in 'Address', with: " "
      click_button 'New Address'

      expect(page).to have_content("address: [\"can't be blank\"]")
      expect(page).to have_button('New Address')
    end

		it 'I cannot change the address if the order has been shipped' do

			visit "/profile/orders/#{@order_3.id}"
			expect(page).to_not have_button('Change Address')

			visit "/profile/orders/#{@order_3.id}/edit"
			expect(page).to have_content("The page you were looking for doesn't exist.")
		end
  end
end
