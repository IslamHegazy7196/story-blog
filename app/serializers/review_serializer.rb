class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :rating, :comment, :user_id,:post_id
end
