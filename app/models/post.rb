class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  has_many :favorites, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_nested_attributes_for :post_images, allow_destroy: true, reject_if: :all_blank

   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
