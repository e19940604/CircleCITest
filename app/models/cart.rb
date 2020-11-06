class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    found_item = items.find{ |item| item.product_id == product_id }

    if found_item
      found_item.increment
    else 
      @items << CartItem.new(product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def remove_item(product_id)
    @items.delete_if {|i| i.product_id == product_id }
  end

  def total_price
    @items.reduce(0){|total, i| total+i.price }
  end

  def serialize
    all_items = items.map{
      |i| {"product_id" => i.product_id, "quantity" => i.quantity}
    }

    { "items" => all_items }
  end

  def self.deserialize(hash)
    if hash.nil?
      new []
    else
      new hash["items"].map{ |item_hash|
        CartItem.new(item_hash["product_id"], item_hash["quantity"])
      }
    end
  end

end
