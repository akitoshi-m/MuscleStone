class Comment < ApplicationRecord
  belongs_to :workout
  belongs_to :user

  validates :content, presence: true
end
