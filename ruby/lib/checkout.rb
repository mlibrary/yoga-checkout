class Price
  def initialize(price)
    @price = price
    @deal_price = nil
    @deal_quantity = nil
  end

  def add_deal(price, quantity)
    @deal_price = price
    @deal_quantity = quantity
  end

  def total(quantity)
    if @deal_quantity.nil?
      @price * quantity

    else
      deals = quantity / @deal_quantity
      extra = quantity % @deal_quantity

      (deals * @deal_price) + (extra * @price)
    end
  end
end

class Checkout
  def initialize(pricing_rules)
    @totals = { }
    @prices = { }

    pricing_rules.each do |item|
      @prices[item[:sku]] = Price.new(item[:price])
      @totals[item[:sku]] = 0

      unless item[:special_quantity].nil?
        @prices[item[:sku]].add_deal(item[:special_price],
                                     item[:special_quantity])
      end
    end
  end

  def scan(item)
    @totals[item] += 1
  end

  def total
    result = 0

    @totals.each do |item, quantity|
      result += @prices[item].total(quantity)
    end

    result
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]

