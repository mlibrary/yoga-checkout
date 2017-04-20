import Checkout from './checkout';

describe('Checkout', () => {
  // This is a table of the items to scan, represented as a string and the
  // expected total for that order.
  // Each row will result in a separate example, so they are independent in
  // the report.
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
  ].forEach((row) => {
    const [items, total] = row;
    it(`prices '${items}' as ${total}`, () => {
      let checkout = new Checkout(Checkout.RULES);
      for (var item of items.split('')) {
        checkout.scan(item);
      }
      expect(checkout.total()).toEqual(total);
    });
  });

  it('tabulates incrementally', () => {
    let checkout = new Checkout(Checkout.RULES);
    [
      ["A", 50],
      ["B", 80],
      ["A", 130],
      ["A", 160],
      ["B", 175],
    ].forEach((row) => {
      const [item, running_total] = row;
      checkout.scan(item);
      expect(checkout.total()).toEqual(running_total);
    });
  });

});

