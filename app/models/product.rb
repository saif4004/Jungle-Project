class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  validate :price_must_be_present

  private

  def price_must_be_present
    errors.add(:price, "can't be blank") if price.nil? || price_cents == 0
  end
end
