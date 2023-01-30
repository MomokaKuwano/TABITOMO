class Route < ApplicationRecord

  has_one_attached :image
  belongs_to :post

  validates :spot, presence: true
  validates :caption, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

def get_image
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.png')
    image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
  end
  image
end

def get_limit_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/user_no_image.png')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
  end
  image.variant(resize_to_limit: [width, height]).processed
end

def get_fill_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/user_no_image.png')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
  end
  image.variant(resize_to_fill: [width, height]).processed
end

end
