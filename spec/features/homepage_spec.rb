require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  describe 'Homepage' do
    it 'should display correctly' do
      skip 'set up acceptance test environment first'
      visit root_path
      expect(page).to have_content 'Lamenting Robot'
    end
  end

  describe 'Article pages' do
    it 'should render 404 if not found' do
      skip 'set up acceptance test environment first'
      visit blog_path('notfound')
      expect(page).to have_content 'Your requested page was not found!'
    end
  end
end
