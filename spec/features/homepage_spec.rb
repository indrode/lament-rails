require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  describe 'Homepage' do
    it 'should display correctly' do
      visit root_path
      expect(page).to have_content 'Lamenting Robot'
    end
  end
end
