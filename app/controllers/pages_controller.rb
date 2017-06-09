class PagesController < ApplicationController
  before_action :load_user, only: :show

  def show
    #@current_order = current_order
    if valid_page?
      # delele_session if user_signed_in?
      render "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root +
      "app/views/pages/#{params[:page]}.html.erb"))
  end

  def load_user
    @users = User.only_sale_man
  end

  def delele_session
    #session[:order_id] = nil
    # order = Order.find session[:order_id]
    order.update_attributes(order_status_id: 2) if user_signed_in?
  end
end
