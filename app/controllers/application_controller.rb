class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied, with: :page_error
  helper_method :current_order

  def current_order
    if session[:order_id].present?
      Order.find session[:order_id]
    else
      order = current_user.orders.create order_status_id: 1
      session[:order_id] = order.id
      byebug
      order
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :username, :email, :phone_number, :image,
        :password, :password_confirmation
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :email, :image, :password, :password_confirmation,
        :current_password
    end
  end

  def page_error
    render template: "public/404", status: 403
  end

  def delele_session
    session[:order_id] = nil
  end

  def find_sale
    @user = User.find_by id: params[:id]
  end
end
