class Checkout

  def initialize(pricing_rules)
    @rules = initialize_rules(pricing_rules)
    @scanned_items = Hash.new(0)
    @total = 0
  end

  def scan(item_sku)
    @scanned_items[item_sku] += 1
    @total += @rules[item_sku].marginal_cost(@scanned_items[item_sku])
  end

  def initialize_rules(pricing_rules)
    pricing_rules.map do |rule|
      [rule[:sku],PriceRule.from_hash(rule)]
    end.to_h
  end

  attr_accessor :total
end

class PriceRule
  def self.from_hash(rule)
    if(rule[:special_quantity]) 
      SpecialPriceRule.new(rule)
    else
      BasicPriceRule.new(rule)
    end
  end

  def marginal_cost
    raise RuntimeError, "unimplemented"
  end
end

class BasicPriceRule < PriceRule
  def initialize(price:, **_)
    @price = price
  end

  def marginal_cost(_)
    @price
  end
end

class SpecialPriceRule < BasicPriceRule
  def initialize(price:, special_quantity:, special_price:, **_)
    super(price: price)
    @special_quantity = special_quantity
    @marginal_special_price = special_price - @price * (@special_quantity - 1)
  end

  # items_so_far: How many items of this kind have we seen so far? 
  # Returns marginal cost of this item
  def marginal_cost(items_so_far)
    if items_so_far % @special_quantity == 0
      @marginal_special_price
    else
      super
    end
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
  {sku: 'E', price: 100, special_quantity: 3, special_price: 150},
]

