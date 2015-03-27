class Article < ActiveRecord::Base
  scope :ordered, -> { order('number DESC') }

  validates :number, :title, :blurb, :filename, :category, :posted_at, presence: true
  validates :blurb, length: { maximum: 255 }
  validates :number, numericality: true, uniqueness: true
end
