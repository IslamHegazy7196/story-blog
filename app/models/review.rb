class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true

  after_create :update_post_average_rating
  after_update :update_post_average_rating
  after_destroy :update_post_average_rating

  private

  def update_post_average_rating
    post.update_average_rating
  end
end
