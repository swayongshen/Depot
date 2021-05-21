class Product < ApplicationRecord
  # Each product can be referenced by many line_items.
  has_many_attached :product_images
  has_many :line_items, dependent: :delete_all
  has_many :orders, through: :line_items
  has_and_belongs_to_many :genres
  belongs_to :user

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validate :acceptable_image

  def acceptable_image
    return unless product_images.attached?

    unless product_images.all? { |image| image.byte_size <= 3.megabyte }
      errors.add(:product_images, "contain an image that is too big")
    end

    acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
    unless product_images.all? { |image| acceptable_types.include?(image.content_type) }
      errors.add(:product_images, "must be a JPG, JPEG or PNG")
    end
  end

  def self.get_all_products_less_than_ten_dollars
    Product.where("price < ?", 10)
  end

  def get_shortened_description
    if description.length > 300
      short_description = description[0..297] + '...'
      ActionController::Base.helpers.sanitize(short_description)
    else
      description
    end
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
