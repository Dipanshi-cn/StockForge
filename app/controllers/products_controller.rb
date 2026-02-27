class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @categories = Category.all
    @products = if params[:category_id]
                  Product.where(category_id: params[:category_id])
                else
                  Product.all
                end
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    render :index
  end
end
