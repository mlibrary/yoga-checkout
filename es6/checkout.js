class Checkout {
  constructor(pricing_rules) {
  }

  scan(item) {
  }

  total() {
    return 0;
  }

  static get RULES() {
    return [
      {sku: 'A', price: 50, special_quantity: 3,    special_price: 130 },
      {sku: 'B', price: 30, special_quantity: 2,    special_price: 45  },
      {sku: 'C', price: 20, special_quantity: null, special_price: null},
      {sku: 'D', price: 15, special_quantity: null, special_price: null},
      {sku: 'E', price: 100, special_quantity: 3, special_price: 150},
    ];
  }
}

export default Checkout;
