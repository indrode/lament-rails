require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:first) { create(:article, number: 20) }
  let!(:disabled) { create(:article, number: 21, enabled: false) }
  let!(:previous) { create(:article, number: 22) }
  let!(:last) { create(:article, number: 23) }

  describe '.enabled_articles' do
    it 'returns an array of enabled articles' do
      expect(Article.enabled_articles).to eq([first, previous, last])
    end
  end

  describe '.previous(article)' do
    it 'returns the previous article number' do
      expect(Article.previous(last)).to eq(previous)
    end

    it 'skips disabled articles' do
      expect(Article.previous(previous)).to eq(first)
    end

    it 'should loop back to last article if first is reached' do
      expect(Article.previous(first)).to eq(last)
    end
  end

  describe '#to_param' do
    it 'returns a parameterized version' do
      expect(first.to_param).to eq('20-article-title')
    end
  end
end
