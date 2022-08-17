class OrdersController < ApplicationController
  def create
    @order = current_user.orders.new(order_params)
    end
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :total_price, :total_quantity, :status, :payment_mode)
  end
end 

