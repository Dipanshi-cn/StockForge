class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin

  def index
    @products = Product.includes(:category).all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "Product created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_admin
    authorize :admin, :index?, policy_class: AdminPolicy
  end

  def product_params
    params.require(:product).permit(:name, :sku, :category_id, :brand, :description, :unit, :cost_price, :selling_price, :stock_quantity, :min_stock_alert, :branch)
  end
end
