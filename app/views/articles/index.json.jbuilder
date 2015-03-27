json.array!(@articles) do |article|
  json.extract! article, :id, :number, :title, :blurb, :filename, :category, :copy, :posted_at
  json.url article_url(article, format: :json)
end
