class OrderApprovalService
  def initialize(order, expected_delivery_date)
    @order = order
    @expected_delivery_date = expected_delivery_date
  end

  def approve!
    return false unless @order.pending?

    Order.transaction do
      @order.order_items.order(:product_id).each do |item|
        product = item.product
        product.lock!
        if product.stock_quantity < item.quantity
          @order.errors.add(:base, "Insufficient stock for #{product.name}")
          raise ActiveRecord::Rollback, "Insufficient stock"
        end
        product.update!(stock_quantity: product.stock_quantity - item.quantity)
      end

      @order.update!(
        status: :approved,
        expected_delivery_date: @expected_delivery_date,
        approved_at: Time.current
      )
    end
    @order.approved?
  rescue ActiveRecord::RecordInvalid => e
    @order.errors.add(:base, "Approval failed: #{e.message}")
    false
  end

  def reject!
    return false unless @order.pending?

    @order.update!(status: :rejected)
  end
end
