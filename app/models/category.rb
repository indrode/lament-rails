class Category < ActiveRecord::Base
  has_many :articles, counter_cache: true
end
