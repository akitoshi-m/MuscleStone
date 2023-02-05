class Workout < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: 'user'
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: 'user'

  # アップローダー
  mount_uploader :image, ImageUploader

  # バリデーション  
  validates :user_id, presence: true
  validates :description, presence: true ,length: {maximum: 140}
  validate :image_size

  private

  # アップロードされた画像のサイズをバリデーションする
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end
end
