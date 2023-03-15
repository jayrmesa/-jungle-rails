class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :adjust_product_quantities

  private

  def adjust_product_quantities
    line_items.each do |line_item|
      line_item.product.quantity = line_item.product.quantity - line_item.quantity
      line_item.product.save
    end
  end
end
