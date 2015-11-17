require 'rails_helper'

def visit_with_basic_auth(path)
  basic = ActionController::HttpAuthentication::Basic
  credentials = basic.encode_credentials(ENV['HTTP_AUTH_USER'], ENV['HTTP_AUTH_PW'])
  page.driver.header('Authorization', credentials)
  visit path
end

RSpec.describe ArticlesController, type: :feature do
  before do
    create(:article, number: 1, posted_at: Date.new(2015, 4, 20), permalink: 'a1')
    create(:category, title: 'CategoryA')
  end

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

  describe 'Adding a new article' do
    it 'should display validation messages' do
      visit_with_basic_auth articles_path
      click_link 'Add a new article'
      click_button 'Create Article'
      expect(page).to have_content 'New Article'
      expect(page).to have_content 'Please review the problems below:'
    end

    it 'should successfully create a new article' do
      visit_with_basic_auth articles_path
      click_link 'Add a new article'
      select('Yes', from: 'Enabled')
      fill_in('Number', with: '23')
      select('CategoryA', from: 'Category')
      fill_in('Title', with: 'Title')
      fill_in('Blurb', with: 'Blurb')
      fill_in('Markdown', with: 'Markdown')
      click_button 'Create Article'
      expect(page).to have_content 'The article was successfully created.'
    end
  end

  describe 'Editing an existing article' do
    it 'should display validation messages' do
      visit_with_basic_auth articles_path
      click_link 'Article Title'
      expect(page).to have_content 'Edit Article'
      fill_in('Title', with: '')
      click_button 'Update Article'
      expect(page).to have_content 'Edit Article'
      expect(page).to have_content 'Please review the problems below:'
    end

    it 'should successfully edit an existing article' do
      visit_with_basic_auth articles_path
      click_link 'Article Title'
      expect(page).to have_content 'Edit Article'
      click_button 'Update Article'
      expect(page).to have_content 'The article was successfully updated.'
    end
  end
end
