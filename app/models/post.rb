class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  after_save :update_average_rating

  def update_average_rating
    new_average_rating = reviews.average(:rating)
    update_column(:average_rating, new_average_rating)
  end
end
