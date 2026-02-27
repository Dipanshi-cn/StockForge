class Admin::DashboardController < ApplicationController
  before_action :authorize_admin

  def index
    @total_categories = Category.count
    @total_products = Product.count
    @total_stock = Product.sum(:stock_quantity)
    @low_stock_products = Product.where("stock_quantity <= min_stock_alert")
    @pending_orders_count = Order.pending.count
    @approved_orders_count = Order.approved.count
    @rejected_orders_count = Order.rejected.count
  end

  private

  def authorize_admin
    authorize :admin, :index?, policy_class: AdminPolicy
  end
end
