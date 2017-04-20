require 'pry'

class Checkout

  attr :cart, :rules 

  def initialize(pricing_rules)
    @rules = index_rules(pricing_rules)
    @cart = []
  end

  def scan(item)
    @cart << item 
  end

  def total
    val = 0
    counted = count_cart(@cart)
    counted.each do |item, qt|
      if @rules[item][:spec_qt] && qt >= @rules[item][:spec_qt]
        val = val + qt % @rules[item][:spec_qt] * @rules[item][:price]
        val = val + qt / @rules[item][:spec_qt] * @rules[item][:spec_price]
      else
        val = val + qt * @rules[item][:price]
      end
    end
    return val
  end

  # Make a hash of sku and quantity
  def count_cart(cart)
    gb = cart.group_by {|item| item}
    mapped = gb.map{|k,v| [k,v.count] }
    Hash[mapped]
  end

  # Hash of hashes 
  # {sku: {price: xx, spec_qt: x, spec_price: x}}
  # rules[sku] = {price: xx, spec_qt: x, spec_price: x}
  def index_rules(rules)
    indexed = Hash.new
    rules.each do |rule|
      indexed[rule[:sku]] = {price: rule[:price], 
                             spec_qt: rule[:special_quantity],
                             spec_price: rule[:special_price]}
    end
    return indexed
  end
end

RULES = [
  {sku: 'A', price: 50, special_quantity: 3,   special_price: 130},
  {sku: 'B', price: 30, special_quantity: 2,   special_price: 45 },
  {sku: 'C', price: 20, special_quantity: nil, special_price: nil},
  {sku: 'D', price: 15, special_quantity: nil, special_price: nil},
]

