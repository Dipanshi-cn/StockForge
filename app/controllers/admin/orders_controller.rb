class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :approve, :reject]
  before_action :authorize_admin

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
  end

  def approve
    service = OrderApprovalService.new(@order, params[:expected_delivery_date])
    if service.approve!
      redirect_to admin_order_path(@order), notice: "Order approved."
    else
      redirect_to admin_order_path(@order), alert: "Approval failed: #{@order.errors.full_messages.to_sentence}"
    end
  end

  def reject
    service = OrderApprovalService.new(@order, nil)
    if service.reject!
      redirect_to admin_order_path(@order), notice: "Order rejected."
    else
      redirect_to admin_order_path(@order), alert: "Rejection failed."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize_admin
    authorize :admin, :index?, policy_class: AdminPolicy
  end
end
