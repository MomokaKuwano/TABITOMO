class Pack < ApplicationRecord

  belongs_to :user
  has_many :packing_lists

end
