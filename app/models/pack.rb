class Pack < ApplicationRecord

  belongs_to :user
  has_many :packing_lists
  has_many :items, through: :packing_lists
  accepts_nested_attributes_for :packing_lists, allow_destroy: true

end
