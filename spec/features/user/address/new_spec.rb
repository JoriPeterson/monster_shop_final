require 'rails_helper'

RSpec.describe 'New User Address' do
  describe 'As a User' do
    before :each do
      @user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click a link to a new address form page' do
      visit user_addresses_path

      click_link 'New Address'

      expect(current_path).to eq("/user/addresses/new")
    end

    it 'I can create an address for a user' do
      name = 'Jori'
      address = "444 Market St"
      city = "Westminster"
      state = 'CO'
      zip = 80021

      visit "/user/addresses/new"

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

      visit "/user/addresses/new"

      fill_in 'Name', with: name
      click_button 'New Address'

      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
      expect(page).to have_button('New Address')
    end
  end
end
