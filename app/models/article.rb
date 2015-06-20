class Article < ActiveRecord::Base
  include PgSearch
  belongs_to :category, counter_cache: true

  scope :ordered, -> { order('number DESC') }
  scope :enabled, -> { where(enabled: true) }
  pg_search_scope :search, against: [:title, :blurb, :markdown]

  validates :number, :title, :blurb, :category, :posted_at, presence: true
  validates :blurb, length: { maximum: 255 },  presence: true
  validates :number, numericality: true, uniqueness: true,  presence: true
  validates :category,  presence: true

  class << self
    def latest
      enabled.ordered.first
    end

    def previous(article)
      enabled_articles[enabled_articles.index(article) - 1]
    end

    def enabled_articles
      enabled.ordered.reverse_each.to_a
    end
  end

  def to_param
    "#{number}-#{title.parameterize}"
  end

  def copy
    M.render(markdown).html_safe
  end
end
