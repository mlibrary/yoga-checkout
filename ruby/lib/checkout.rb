class Checkout
  def initialize(pricing_rules)
    @rules = pricing_rules
    @totals = Hash.new(0)
  end

  def scan(item)
   @totals[item] += 1
  end

  def total
    retval = 0
    @totals.each do |item, num_purchased|
        rule = _get_rule(item)
        if rule[:special_quantity]
            num_special = ( num_purchased / rule[:special_quantity] ).to_i
            retval += num_special * rule[:special_price]
            num_purchased = ( num_purchased % rule[:special_quantity] )
        end
        retval += num_purchased * rule[:price]
    end
    retval
  end

  def _get_rule(item)
    @rules.select{|rule| rule[:sku] == item}.first
    #active = nil
    #@rules.each do |rule|
    #    if rule[:sku] == item
    #        active = rule
    #        break
    #    end
    #end
    #active
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]

