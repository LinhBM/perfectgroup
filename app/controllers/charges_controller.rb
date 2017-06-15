class ChargesController < ApplicationController
  include ChargesHelper

  def new
    @payment = current_user.payments.build
    @order_items = current_order.order_items
  end

  def create
    @order_items = current_order.order_items
    @payment = current_user.payments.create payment_params
    @payment.process_payment params[:stripeEmail], params[:stripeToken]
    current_order.update_order_status
  rescue Stripe::CardError => error
    flash[:error] = error.message
    redirect_to new_charge_url
  end

  private
  def payment_params
    params.require(:payment).permit :amount, :description, :address, :user_id
  end
end
