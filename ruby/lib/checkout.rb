class Checkout

  def initialize(pricing_rules)
    @rules = initialize_rules(pricing_rules)
    @scanned_items = Hash.new(0)
    @total = 0
  end

  def scan(item_sku)
    @scanned_items[item_sku] += 1
    @total += @rules[item_sku].price_for_this_one(@scanned_items[item_sku])
  end

  def initialize_rules(pricing_rules)
    pricing_rules.map do |rule|
      [rule[:sku],PriceRule.new(rule)]
    end.to_h
  end

  attr_accessor :total
end

class PriceRule
  def initialize(**args)
    @price = args[:price]
    @special_quantity = args[:special_quantity]
    @special_price = args[:special_price]
  end

  def price_for_this_one(how_many_total)
    return price if special_quantity.nil?

    if how_many_total % special_quantity == 0
      special_price - price * (special_quantity - 1)
    else
      price
    end
  end

  attr_accessor :price, :special_quantity, :special_price
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
  {sku: 'E', price: 100, special_quantity: 3, special_price: 150},
]

