class Item < ApplicationRecord

  has_many :packing_lists
  belongs_to :user
  has_many :lists, through: :packing_lists

  validates :name, presence: true

end
