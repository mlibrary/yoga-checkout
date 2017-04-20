class Checkout
  def initialize(pricing_rules)
    @rules = {}
    pricing_rules.each do | rule |
      @rules[rule[:sku]] = rule
    end

    # sku => count
    @items = Hash.new 0
  end

  def scan(item)
    @items[item] += 1 
  end

  def total
    @total = 0
    @items.each do | sku, count |
      if @rules[sku][:special_quantity].nil?
        @total += count * @rules[sku][:price]
      else
        @total += (count / @rules[sku][:special_quantity]).floor * @rules[sku][:special_price]
        @total += (count % @rules[sku][:special_quantity]) * @rules[sku][:price]
      end
    end
    @total
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]

