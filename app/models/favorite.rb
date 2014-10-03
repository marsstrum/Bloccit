class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # favorite object => {id: 1, user_id: 1, post_id: 1}
end
