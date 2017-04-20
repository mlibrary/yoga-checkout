class Checkout
  attr_accessor :sum, :tally
  def initialize(pricing_rules)
    @sum = 0
    @tally = {}
  end

  def scan(item)
    if @tally[item]
      @tally[item] += 1
    else
      @tally[item] = 1
    end
    @sum += case item
      when 'A'
        50
      when 'B'
        30
      when 'C'
        20
      when 'D'
        15
      else
        0
    end
  end

  def total
    @tally.each do |k,v|
      case k
      when 'A'
        @sum -= 20 * (v / 3).floor if v >= 3
        
      when 'B'
        @sum -= 15 * (v / 2).floor if v >= 2
      end
    end
    @sum
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]
