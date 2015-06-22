class Category < ActiveRecord::Base
  has_many :articles

  class << self
    def recent(limit = 5)
      OpenStruct.new(title: 'recently', articles: Article.recent(limit))
    end
  end
end
