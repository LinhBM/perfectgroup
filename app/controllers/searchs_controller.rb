class SearchsController < ApplicationController
  def index
    keyword = params[:search][:keyword]
    if keyword.present?
      @users = User.search keyword
      @products = Product.search keyword
    end
  end
end
