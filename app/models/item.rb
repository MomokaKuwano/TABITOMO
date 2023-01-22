class Item < ApplicationRecord

  has_many :packing_lists
  belongs_to :user
  has_many :packs, through: :packing_lists

  validates :name, presence: true

end
