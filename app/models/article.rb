class Article < ActiveRecord::Base
  scope :ordered, -> { order('number DESC') }
  scope :enabled, -> { where(enabled: true) }

  validates :number, :title, :blurb, :category, :posted_at, presence: true
  validates :blurb, length: { maximum: 255 }
  validates :number, numericality: true, uniqueness: true

  def copy_copy # TODO: rename to copy and database field copy -> markdown
    M.render(copy).html_safe
  end
end
