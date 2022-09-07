require 'rails_helper'

RSpec.describe 'application creation' do

  describe 'content' do
    it 'renders the form' do
      visit '/applications/new'
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
    end
  end

  describe 'application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/applications/new'

        fill_in 'Name', with: 'Guy Manfred'
        fill_in 'Address', with: '101 Pearson RD'
        fill_in 'City', with: 'Glendale'
        fill_in 'State', with: 'CA'
        fill_in 'Zipcode', with: '11121'
        click_button 'Submit'

        expect(page).to have_content('Guy Manfred')
        expect(page).to have_content('101 Pearson RD')
        expect(page).to have_content('Glendale')
        expect(page).to have_content('CA')
        expect(page).to have_content('11121')
        expect(page).to have_content('In Progress')
        expect(page).to have_content('Fill out after adding pets please.')
      end
    end

    context 'given incomplete data' do
      it 'makes you fill out the whole form before redirecting' do
        visit '/applications/new'

        fill_in 'Name', with: 'Guy Manfred'
        fill_in 'Address', with: '101 Pearson RD'
        click_button 'Submit'
        expect(page).to have_content('Please fill out the whole form')
      end
    end

    context 'the saddest path' do
      it 'wont accept spaces as input' do
        visit '/applications/new'

        fill_in 'Name', with: ' '
        fill_in 'Address', with: ' '
        fill_in 'City', with: ' '
        fill_in 'State', with: ' '
        fill_in 'Zipcode', with: ' '
        click_button 'Submit'
        expect(page).to have_content('Please fill out the whole form')
      end

      it 'wont accept it with any combination of bad data 1' do
        visit '/applications/new'

        fill_in 'Name', with: ' '
        fill_in 'Address', with: 'placeholder'
        fill_in 'City', with: 'placeholder'
        fill_in 'State', with: 'placeholder'
        fill_in 'Zipcode', with: 'placeholder'
        click_button 'Submit'
        expect(page).to have_content('Please fill out the whole form')
      end

      it 'wont accept it with any combination of bad data 2' do
        visit '/applications/new'

        fill_in 'Name', with: "placeholder"
        fill_in 'Address', with: '  '
        fill_in 'City', with: 'placeholder'
        fill_in 'State', with: 'placeholder'
        fill_in 'Zipcode', with: 'placeholder'
        click_button 'Submit'
        expect(page).to have_content('Please fill out the whole form')
      end

      it 'wont accept it with any combination of bad data 3' do
        visit '/applications/new'

        fill_in 'Name', with: "placeholder"
        fill_in 'Address', with: 'placeholder'
        fill_in 'City', with: ' '
        fill_in 'State', with: 'placeholder'
        fill_in 'Zipcode', with: 'placeholder'
        click_button 'Submit'
        expect(page).to have_content('Please fill out the whole form')
      end
    end


  end

end
