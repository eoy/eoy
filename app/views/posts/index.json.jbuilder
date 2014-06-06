json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :header_image, :image
  json.url post_url(post, format: :json)
end
