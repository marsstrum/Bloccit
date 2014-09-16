class Comment < ActiveRecord::Base
  belongs_to :post  # my_comment.post
  belongs_to :user  #my_comment.user

  validates :body, length: { minimum: 5}, presence: true
  validates :user, presence: true
end
