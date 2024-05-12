class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body,:average_rating
end
