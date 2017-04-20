class PricingRules
  def initialize(rules)
    @rules = rules.inject({}) do |acc, rule|
      acc[rule[:sku]] = PricingRule.new(rule)
      acc
    end
  end

  def apply(total)
    sum = 0
    total.each_pair do |k, val|
      sum += @rules[k].apply(val)
    end
    sum
  end

  def [] (index)
    @rules[index]
  end
end

class PricingRule
  attr_accessor :sku, :price, :special_quantity, :special_price

  def initialize(rule)
    @sku = rule[:sku]
    @price = rule[:price]
    @special_quantity = rule[:special_quantity]
    @special_price = rule[:special_price]
  end

  def apply(value)
    if @special_quantity
      return (value % @special_quantity) * @price +
        (value / @special_quantity).to_i  * @special_price
    else
      return value * @price
    end
  end
end

class RunningTotal
  def initialize(rules)
    @running_total = rules.map {|rule| [rule[:sku], 0]}.to_h
  end

  def [](key)
    @running_total[key]
  end

  def []=(key, value)
    @running_total[key] = value
  end
  def has_key?(key)
    @running_total.has_key?(key)
  end

  def each_pair &block
    @running_total.each_pair(&block)
  end
end

class Checkout
  def initialize(pricing_rules)
    @running_total = RunningTotal.new(pricing_rules)
    @pricing_rules = PricingRules.new(pricing_rules)
  end

  def scan(item)
    return unless @running_total.has_key?(item)
    @running_total[item] += 1
  end

  def total
    @pricing_rules.apply(@running_total)
  end

end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
  {sku: 'E', price: 100, special_quantity: 3, special_price: 150},
]

