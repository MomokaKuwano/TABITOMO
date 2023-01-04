class PackingList < ApplicationRecord
  
  belongs_to :pack
  belongs_to :item
  
end
