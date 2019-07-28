require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Cart Show Page' do
  describe 'As a User' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '888 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)
			@address_3 = @user.addresses.create!(name: 'Megan', address: '940 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 2)
			@address_4 = @user.addresses.create!(name: 'Mrs. Roberts', address: '111 Sheridan Ave', city: 'Las Vegas', state: 'NV', zip: 89218, nickname: 3)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can choose my address for my cart" do
      visit item_path(@ogre)
      click_button 'Add to Cart'
      visit item_path(@giant)
      click_button 'Add to Cart'
      visit item_path(@giant)
      click_button 'Add to Cart'

      visit '/cart'

			page.select("Home: Megan 123 Main St Denver CO 80218", :from => @addresses)
			expect(page).to have_content("#{@address_1.nickname}: #{@address_1.name} #{@address_1.address} #{@address_1.city} #{@address_1.state} #{@address_1.zip}")
		end

		xit "I cannot checkout without an address" do

		end
	end
end
