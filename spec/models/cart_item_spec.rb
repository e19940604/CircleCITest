require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "cauclate the each price of item" do
    p1 = Product.create( title: "Book1", price: 100)
    p2 = Product.create( title: "Book2", price: 120)

    cart = Cart.new
    3.times{ cart.add_item(p1.id) }
    2.times{ cart.add_item(p2.id) }

    expect(cart.items.first.price).to be 300
    expect(cart.items.second.price).to be 240
  end

  it "cauclate total price of cart" do
    p1 = Product.create( title: "Book1", price: 100)
    p2 = Product.create( title: "Book2", price: 120)

    cart = Cart.new
    3.times{ cart.add_item(p1.id) }
    2.times{ cart.add_item(p2.id) }

    expect(cart.total_price).to be 540
  end

end
