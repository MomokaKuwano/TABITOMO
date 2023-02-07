class List < ApplicationRecord

  belongs_to :user
  has_many :packing_lists
  has_many :items, through: :packing_lists
  accepts_nested_attributes_for :packing_lists, allow_destroy: true

#  validates_associated :items
  validates :packing_lists, presence: true
  validates :pack_title, presence: true

end
