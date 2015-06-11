require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:enabled_article) { Article.new(enabled: true, number: 23) }

  describe '.previous' do
    it 'returns the previous article number' do
      expect(enabled_article.previous).to eq(22)
    end
  end
end
