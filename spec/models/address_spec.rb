require 'rails_helper'

RSpec.describe Address do
  describe 'Relationships' do
    it {should belong_to :user }
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
			@user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
			@address_1 = @user.addresses.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, nickname: 0)
		end

		it 'display' do
			expect(@address_1.display).to eq("Home: Megan 123 Main St Denver CO 80218")
		end
	end
end
