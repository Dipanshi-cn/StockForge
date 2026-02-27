class OrdersController < ApplicationController
  def index
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def new
    if current_cart.cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
    else
      @order = current_user.orders.build
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = :pending
    @order.total_amount = current_cart.total_amount

    if @order.save
      current_cart.cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.selling_price
        )
      end
      current_cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: "Order placed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:delivery_address, :contact_number, :notes)
  end
end
