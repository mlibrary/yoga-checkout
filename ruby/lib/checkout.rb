require 'dry-initializer'

class Rule
  extend Dry::Initializer::Mixin
  option :price
  option :special_quantity
  option :special_price


  def cost_for(quantity)
    if special_quantity.nil?
      quantity * price
    else
      sets = quantity.div(special_quantity)
      singles = quantity % special_quantity
      sets * special_price + singles * price
    end
  end
end


class Checkout

  def initialize(pricing_rules)
    @rules = self.create_rules(pricing_rules)
    @scanned_products   = Hash.new { 0 }
  end


  def create_rules(pricing_rules)
    pricing_rules.inject({}) do |rules, pr|
      r               = Rule.new(pr)
      rules[pr[:sku]] = r
      rules
    end
  end

  def scan(sku)
    @scanned_products[sku] += 1
  end

  def total
    @scanned_products.map do |sku, num|
      @rules[sku].cost_for(num)
    end.sum
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3, special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2, special_price: 45},
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]

