class Post < ApplicationRecord
  
  has_many :routes
  accepts_nested_attributes_for :routes
  belongs_to :user
  
end
