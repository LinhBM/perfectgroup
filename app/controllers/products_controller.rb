class ProductsController < ApplicationController
  include ProductsHelper
  before_action :find_user, only: :index
  before_action :find_product, except: [:index, :new, :create]
  before_action :load_category, only: [:new, :edit]
  before_action :load_order, only: [:index, :show]

  def index
    if params[:search].present?
      @products = Product.search(params[:search])
    else
      @products = @user.products
    end
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build product_params
    if @product.save
      redirect_to user_products_url current_user
    else
      render :new
    end
  end

  def show
    @comment = CommentProduct.new
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to user_products_url current_user
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to user_products_path current_user
  end

  private
  def product_params
    params.require(:product).permit :id, :title, :price, :description,
      :avg_rating, :category_id, :product_image, :user_id
  end

  def find_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:error] = t "product_not_found"
      redirect_to root_url
    end
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:error] = t "user_not_found"
      redirect_to root_url
    end
  end

  def load_category
    @user = Category.all
  end

  def load_order
    @order_item = current_order.order_items.new if user_signed_in?
  end
end
