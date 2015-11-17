require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  let!(:category) { create(:category, title: 'personal') }

  describe 'Errors' do
    before do
      create(:article, number: 1)
    end

    it 'routing should redirect to the homepage' do
      visit '/routing/error'
      expect(page.current_path).to eq(root_path)
      expect(page).to have_content 'Lamenting Robot'
    end

    it 'server errors should redirect to the homepage' do
      visit '/500'
      expect(page.current_path).to eq(root_path)
      expect(page).to have_content 'Lamenting Robot'
    end
  end

  describe 'Homepage' do
    it 'should display correctly' do
      create(:article, number: 1)
      visit root_path
      expect(page).to have_content 'Lamenting Robot'
      expect(page).to have_content 'start browsing'
    end

    it 'should display articles' do
      create(:article, title: 'Test111', number: 1)
      visit root_path
      expect(page).to have_content 'Test111'
    end

    it 'should not display disabled articles' do
      create(:article, title: 'Enabled', number: 1)
      create(:article, title: 'Disabled', number: 2, enabled: false)
      visit root_path
      expect(page).to have_content 'Enabled'
      expect(page).not_to have_content 'Disabled'
    end

    it 'should display links to categories' do
      create(:article)
      visit root_path
      click_link('personal')
      expect(current_path).to eq(category_path(category.title))
    end
  end

  describe 'Article pages' do
    it 'should render 404 if not found' do
      visit blog_path('notfound')
      expect(page).to have_content 'Your requested page was not found!'
    end

    it 'should render an article page' do
      create(:article, number: 1, posted_at: Date.new(2015, 4, 20), permalink: 'a1')
      visit blog_path('a1')
      expect(page).to have_content 'Article Title'
      expect(page).to have_content 'This is the main article copy.'
      expect(page).to have_content 'Apr 20, 2015'
    end

    it 'should display navigation link on homepage' do
      create(:article, number: 1, posted_at: Date.new(2015, 4, 20), permalink: 'a1')
      visit blog_path('a1')
      expect(page).to have_content 'previous article'
      expect(page).to have_content 'view all'
    end

    it 'should display a link to the article\'s category' do
      create(:article, number: 1, category: category, permalink: 'a1')
      visit blog_path('a1')
      expect(page).to have_content 'personal'
      click_link('personal')
      expect(current_path).to eq(category_path(category.title))
    end
  end
end
