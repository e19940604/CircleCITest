require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "The basic of cart", type: :model do
    it "Send products to cart" do
      cart = Cart.new
      cart.add_item 1
      expect(cart.empty?).to be false
    end

    it "if you send the same item to cart , it only plus numbers" do
      cart = Cart.new
      3.times { cart.add_item(1) }
      5.times { cart.add_item(2) }
      2.times { cart.add_item(3) }

      expect(cart.items.length).to be 3
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.quantity).to be 5
    end

    it "delete from cart" do
      cart = Cart.new
      cart.add_item(1)
      cart.add_item(2)
      cart.remove_item(1)
      expect(cart.items.first.product_id).to be 2
    end

    it "change cart as hash for saving to session" do
      cart = Cart.new
      3.times{ cart.add_item(2) }
      4.times{ cart.add_item(5) }

      expect(cart.serialize).to eq session_hash

    end

    it "get hash data from session to cart" do 
      cart = Cart.deserialize( session_hash )
      expect(cart.items.first.product_id).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.product_id).to be 5
      expect(cart.items.second.quantity).to be 4
    end



    private 
    def session_hash
      {
        "items" => [
          {"product_id" => 2, "quantity" => 3},
          {"product_id" => 5, "quantity" => 4}
        ]
      }
    end


  end

end
