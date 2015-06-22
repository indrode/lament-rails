class Category < ActiveRecord::Base
  has_many :articles

  class << self
    def recent(limit = 5)
      OpenStruct.new(
        title: 'recently',
        description: 'The most recently posted articles.',
        articles: Article.recent(limit)
      )
    end
  end
end
