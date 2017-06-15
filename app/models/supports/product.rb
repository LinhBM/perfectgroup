class Supports::Product
  attr_reader :product, :order

  def initialize product, current_order
    @product = product
    @order = current_order
  end

  def comment
    @comment ||= CommentProduct.new
  end

  def category
    @category ||= Category.all
  end

  def order_item
    @order_item = @order.order_items.new
  end
end
