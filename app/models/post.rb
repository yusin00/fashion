class Post < ApplicationRecord
 
 
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  has_many :tagmaps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_one_attached :image

  accepts_nested_attributes_for :post_images, allow_destroy: true, reject_if: :all_blank

 
  #検索メソッド、タイトルと内容をあいまい検索する
 def self.posts_serach(search)
   Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
 end
   

  def save_posts(tag_list)
      # Create
     new_tags.each do |new_name|
     post_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << post_tag
     end
  end
 
 
 
 
   def save_posts(tag_list)
    tag_list.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      self.tags << tag
    end
   end


 
   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
   end
end
