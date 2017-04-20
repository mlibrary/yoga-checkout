require 'checkout'

RSpec::describe Checkout do
  # This is a table of the items to scan, represented as a string and the
  # expected total for that order.
  # Each row will result in a separate example, so they are independent in
  # the report.
  describe "#total" do
    [
      ["",         0],
      ["A",       50],
      ["AB",      80],
      ["CDBA",   115],

      ["AA",     100],
      ["AAA",    130],
      ["AAAA",   180],
      ["AAAAA",  230],
      ["AAAAAA", 260],

      ["AAAB",   160],
      ["AAABB",  175],
      ["AAABBD", 190],
      ["DABABA", 190],

      ["E", 100],
      ["EE", 200],
      ["EEE", 150]
    ].each do |items, total|
      it "prices '#{items}' as #{total}" do
        checkout = Checkout.new(RULES)
        items.split(//).each {|item| checkout.scan(item) }
        expect(checkout.total).to eq(total)
      end
    end

    it "tabulates incrementally" do
      checkout = Checkout.new(RULES)
      expect(checkout.total).to eq(0)
      [
        ["A", 50],
        ["B", 80],
        ["A", 130],
        ["A", 160],
        ["B", 175],
      ].each do |item, running_total|
        checkout.scan(item)
        expect(checkout.total).to eq(running_total)
      end
    end
  end

end

