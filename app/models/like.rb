class Like < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  # 1人が1つの投稿に対して、1つしかいいねをつけられないようにする
  validates_uniqueness_of :post_id, scope: :user_id
  
  
  
end
