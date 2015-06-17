require 'rails_helper'

def visit_with_basic_auth(path)
  basic = ActionController::HttpAuthentication::Basic
  credentials = basic.encode_credentials(ENV['HTTP_AUTH_USER'], ENV['HTTP_AUTH_PW'])
  page.driver.header('Authorization', credentials)
  visit path
end

RSpec.describe ArticlesController, type: :feature do
  before { create(:article, number: 1, posted_at: Date.new(2015, 4, 20)) }

  describe 'Admin Interface' do
    it 'should display correctly' do
      visit_with_basic_auth articles_path
      expect(page).to have_content 'Admin Interface'
    end

    it 'should display article information' do
      visit_with_basic_auth articles_path
      expect(page).to have_content 'Article Title'
      expect(page).to have_content 'category'
      expect(page).to have_content '1'
    end

    it 'should display the \'edit\' page' do
      visit_with_basic_auth articles_path
      click_link 'Article Title'
      expect(page).to have_content 'Edit Article'
    end

    it 'should display the \'new\' page' do
      visit_with_basic_auth articles_path
      click_link 'Add a new article'
      expect(page).to have_content 'New Article'
    end
  end
end
