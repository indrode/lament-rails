require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  describe 'Homepage' do
    it 'should display correctly' do
      visit root_path
      expect(page).to have_content 'Lamenting Robot'
    end
  end

  describe 'Article pages' do
    it 'should render 404 if not found' do
      visit blog_path('notfound')
      expect(page).to have_content 'Your requested page was not found!'
    end

    it 'should render an article page' do
      create(:article, number: 1, posted_at: Date.new(2015, 4, 20))
      visit blog_path(1)
      expect(page).to have_content 'Article Title'
      expect(page).to have_content 'This is the main article copy.'
      expect(page).to have_content '2015-04-20'
    end
  end
end
