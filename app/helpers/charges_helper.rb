module ChargesHelper
  def get_description order_items
    prefix = "You'd just bought: \n"
    description = ""
    order_items.each do |oi|
      description += oi.product.title + " x " + oi.quantity.to_s + "\n"
    end
    prefix + description
  end

  def reset_sessions
    session.delete(:order_id)
  end
end
