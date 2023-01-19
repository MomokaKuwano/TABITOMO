class Item < ApplicationRecord

  has_many :packing_lists
  belongs_to :user

  validates :name, presence: true

end
