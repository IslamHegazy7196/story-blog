class AddAverageRatingToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :average_rating, :decimal, precision: 3, scale: 2
  end
end
