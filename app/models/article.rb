class Article < ActiveRecord::Base
  belongs_to :category, counter_cache: true

  scope :ordered, -> { order('number DESC') }
  scope :enabled, -> { where(enabled: true) }

  validates :number, :title, :blurb, :category, :posted_at, presence: true
  validates :blurb, length: { maximum: 255 }
  validates :number, numericality: true, uniqueness: true

  class << self
    def latest
      enabled.ordered.first
    end

    def previous(article)
      enabled_articles[enabled_articles.index(article) - 1]
    end

    def enabled_articles
      enabled.ordered.reverse.each.to_a
    end
  end

  def to_param
    "#{number}-#{title.parameterize}"
  end

  def copy_copy # TODO: rename to copy and database field copy -> markdown
    M.render(copy).html_safe
  end
end
