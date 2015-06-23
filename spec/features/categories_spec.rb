require 'rails_helper'

RSpec.describe CategoriesController, type: :feature do
  let!(:category) { create(:category, title: 'personal') }
  let!(:article) { create(:article, title: 'Test111', number: 1, category: category) }

  describe 'Category page' do
    it 'should display correctly' do
      visit category_path(category.title)
      expect(page).to have_content 'Lamenting Robot'
      expect(page).to have_content 'Personal'
    end

    it 'should display articles' do
      visit category_path(category.title)
      expect(page).to have_content 'Test111'
    end
  end
end
