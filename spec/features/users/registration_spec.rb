require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'As a Visitor' do
    it 'I see a link to register as a user' do
      visit root_path

      click_link 'Register'

      expect(current_path).to eq(registration_path)
    end

    it 'I can register as a user' do
      visit registration_path

      fill_in 'Name', with: 'Megan'
      fill_in 'Email', with: 'megan@example.com'
      fill_in 'Password', with: 'securepassword'
      fill_in 'Password confirmation', with: 'securepassword'
      click_button 'Next'

      expect(current_path).to eq(address_registration_path)

			fill_in 'Name', with: 'Megan'
			fill_in 'Address', with: '123 Main St'
			fill_in 'City', with: 'Denver'
			fill_in 'State', with: 'CO'
			fill_in 'Zip', with: '80218'
			click_button "Register"

			expect(current_path).to eq(profile_path)
			expect(page).to have_content('Welcome, Megan!')
    end

    describe 'I can not register as a user if' do
      it 'I do not complete the registration form' do
				visit registration_path

        fill_in 'Name', with: 'Megan'
        click_button 'Next'

        expect(page).to have_button('Next')
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it 'I use a non-unique email' do
        user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
        visit registration_path

        fill_in 'Name', with: user.name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: '123'
        fill_in 'Password confirmation', with: '123'
        click_button 'Next'

        expect(page).to have_button('Next')
        expect(page).to have_content("Email has already been taken")
      end


			it 'I cant leave part of the form blank' do
				user = User.create(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
				visit registration_path

				fill_in 'Name', with: 'Charter'
				fill_in 'Email', with: 'charter@gmail.com'
				fill_in 'Password', with: user.password
				fill_in 'Password confirmation', with: user.password
				click_button 'Next'

				fill_in 'Name', with: "Charter"

				click_button 'Register'

				expect(page).to have_button('Register')

				expect(page).to have_content("Address can't be blank")
				expect(page).to have_content("City can't be blank")
				expect(page).to have_content("State can't be blank")
				expect(page).to have_content("Zip can't be blank")
			end
    end
  end
end
