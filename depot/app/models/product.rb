class Product < ApplicationRecord
  # Each product can be referenced by many line_items.
  has_one_attached :product_image
  has_many :line_items, dependent: :delete_all
  has_many :orders, through: :line_items
  belongs_to :user

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:
      %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validate :acceptable_image

  def acceptable_image
    return unless product_image.attached?

    unless product_image.byte_size <= 2.megabyte
      errors.add(:product_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
    unless acceptable_types.include?(product_image.content_type)
      errors.add(:main_image, "must be a JPG, JPEG or PNG")
    end
  end

  def self.get_all_products_less_than_ten_dollars
    Product.where("price < ?", 10)
  end

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
