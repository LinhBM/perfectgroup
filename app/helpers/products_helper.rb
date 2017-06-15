module ProductsHelper
  def find_product
    @product = Product.find_by id: params[:product_id]
    unless @product
      flash[:error] = t "product_not_found"
      redirect_to root_url
    end
  end
end
