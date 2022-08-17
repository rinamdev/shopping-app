class LineitemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = current_user.orders.last
    if @order
      if @order.cart?
        @lineitems = @order.lineitems
      else
        @lineitem = nil
      end
    else
      @lineitem = nil
    end 
  end

  def create
    @order = current_user.orders.last
    if @order 
      if @order.cart?
        @lineitem = current_user.orders.last.lineitems.new(carts_params)
        @lineitem.user_id = current_user.id
        if @lineitem.save
          @order = current_user.orders.last
          @order.total_price = @order.total_price + (@lineitem.price * @lineitem.quantity)
          @order.total_quantity = @order.total_quantity + @lineitem.quantity
          @order.save
          redirect_to root_path
        end
      else 
        sample
      end
    else
      sample
    end
  end

  def update
    @order = current_user.orders.last
    @lineitem = current_user.orders.last.lineitems.where(product_id: params[:product_id]).first
    @old_quantity  =  @lineitem.quantity 
    if @lineitem.update(lineitem_params)
      if @old_quantity  > @lineitem.quantity 
        @order = current_user.orders.last
        @order.total_price = @order.total_price - (@lineitem.price * @lineitem.quantity)
        @order.total_quantity = @order.total_quantity - @lineitem.quantity
        @order.save
      elsif @old_quantity  <  @lineitem.quantity 
        @incress_quantity = @lineitem.quantity - @old_quantity
        @order = current_user.orders.last
        @order.total_price = @order.total_price + (@lineitem.price * @incress_quantity)
        @order.total_quantity = @order.total_quantity + @incress_quantity
        @order.save
      end
      redirect_to lineitems_path
    end
  end

  def payment
    @order = current_user.orders.last
    unless @order && @order.cart?
      @order == nil
    end
  end

  def place_order
    @order = Order.find(params[:order][:id])
    if @order.update(placeOrder_params)
      @order.payment!
      redirect_to order_details_path(order_id: @order.id)	
    end  
  end

  def order_detail
    @order = Order.find(params[:order_id])
    @lineitems = @order.lineitems
  end

  def destroy
    @lineitem = Lineitem.find(params[:id])
    @old_quantity  =  @lineitem.quantity 
    @lineitem.destroy
    if @old_quantity  > @lineitem.quantity 
      @order = current_user.orders.last
      @order.total_price = @order.total_price - (@lineitem.price * @lineitem.quantity)
      @order.total_quantity = @order.total_quantity - @lineitem.quantity
      @order.save
    end
    redirect_to lineitems_path
  end


  private
  
  def carts_params
    params.permit(:price, :quantity, :product_id)
  end
  def lineitem_params
    params.permit(:quantity, :product_id)
  end

  def placeOrder_params
    params.require(:order).permit(:payment_mode)
  end

  def sample
    @order = current_user.orders.new(total_price: 0, total_quantity: 0)
    if @order.save
      @order.cart!
      @lineitem = current_user.orders.last.lineitems.new(carts_params)
      @lineitem.user_id = current_user.id
      if @lineitem.save
        @order = current_user.orders.last
        @order.total_price = @order.total_price + (@lineitem.price * @lineitem.quantity)
        @order.total_quantity = @order.total_quantity + @lineitem.quantity
        @order.save
        redirect_to root_path
      end
    end
  end

end
