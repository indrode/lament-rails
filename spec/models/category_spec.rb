require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'class methods' do
    describe '.recent' do
      let(:articles) { %w(a1 a2 a3 a4 a5) }

      it 'returns an OpenStruct with recent articles' do
        allow(Article).to receive(:recent).with(5).and_return articles
        c = Category.recent
        expect(c.title).to eq('recently')
        expect(c.articles).to eq(articles)
      end

      it 'returns the given number of articles' do
        allow(Article).to receive(:recent).with(3).and_return articles[0..3]
        c = Category.recent(3)
        expect(c.title).to eq('recently')
        expect(c.articles).to eq(articles[0..3])
      end
    end
  end
end
