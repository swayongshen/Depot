class Product < ApplicationRecord
  belongs_to :seller
  has_many :line_items

  validates :name, :description, :image, presence:true
  #Price is at least 1 cent
  validates :price, numericality: {greater_than_or_equal_to:  0.01}
  validates :title, uniqueness:true
  validates :image_url, allow_blank: true, format: {
    with:
      %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }


end
