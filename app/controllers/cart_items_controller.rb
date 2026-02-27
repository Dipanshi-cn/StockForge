class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @cart_item = current_cart.cart_items.find_or_initialize_by(product: product)
    
    if @cart_item.new_record?
      @cart_item.quantity = params[:quantity].to_i
    else
      @cart_item.quantity += params[:quantity].to_i
    end

    if @cart_item.save
      redirect_to cart_path, notice: "Product added to cart."
    else
      redirect_to product_path(product), alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def update
    @cart_item = current_cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: "Quantity updated."
    else
      redirect_to cart_path, alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Product removed from cart."
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
