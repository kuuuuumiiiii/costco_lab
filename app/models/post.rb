class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :wants, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
end
