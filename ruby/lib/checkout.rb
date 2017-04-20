class Checkout
  def initialize(pricing_rules)
  end

  def scan(item)
  end

  def total
    0
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
  {sku: 'E', price: 100, special_quantity: 3, special_price: 150},
]

