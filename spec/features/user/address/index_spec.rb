require 'rails_helper'

RSpec.describe 'Merchant Index Page' do
  describe 'As a visitor' do
    before :each do
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '888 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a list of all addresses' do
      visit user_addresses_path

      within "#address-#{@address_1.id}" do
        expect(page).to have_content(@address_1.nickname)
        expect(page).to have_content(@address_1.name)
        expect(page).to have_content(@address_1.address)
        expect(page).to have_content(@address_1.city)
        expect(page).to have_content(@address_1.state)
        expect(page).to have_content(@address_1.zip)
      end

      within "#address-#{@address_2.id}" do
        expect(page).to have_content(@address_2.nickname)
				expect(page).to have_content(@address_2.name)
        expect(page).to have_content(@address_2.address)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
        expect(page).to have_content(@address_2.zip)
      end
    end
  end
end
