require 'rails_helper'

RSpec.describe 'Delete Address' do
  describe 'As a user' do
    before :each do
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
			@address_2 = @user.addresses.create!(name: 'Megan', address: '888 Market St', city: 'Denver', state: 'CO', zip: 80218, nickname: 1)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click button to delete an address' do
      visit user_addresses_path

			within "#address-#{@address_2.id}" do
				click_link 'Delete Address'
			end

			expect(current_path).to eq(user_addresses_path)
      # expect(page).to_not have_content(@address_2.address)
    end

    describe 'If a user has orders that have been shipped' do
      xit 'I do not see a button to delete the address' do
        visit profile_path

				within "#address-#{@address_2.id}" do
					expect(page).to_not have_link('Delete Address')
				end
      end

      xit 'I can not delete a merchant' do
        page.driver.submit :delete, merchant_path(@megan), {}

        expect(page).to have_content(@megan.name)
        expect(page).to have_content("#{@megan.name} can not be deleted - they have orders!")
      end
    end
  end
end
