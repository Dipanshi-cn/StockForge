require "test_helper"

class OrderFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @customer = User.create!(email: "cust_#{rand(10000)}@test.com", password: 'password', password_confirmation: 'password', role: :customer)
    @admin = User.create!(email: "admin_#{rand(10000)}@test.com", password: 'password', password_confirmation: 'password', role: :admin)
    @category = Category.create!(name: "Tools_#{rand(10000)}")
    @product = Product.create!(
      name: "Hammer_#{rand(10000)}", sku: "HAM_#{rand(10000)}", category: @category, 
      selling_price: 10.00, stock_quantity: 5, unit: 'Piece'
    )
  end

  test "customer can place order and stock remains unchanged until admin approves" do
    sign_in @customer
    
    # Add to cart
    post cart_items_path, params: { product_id: @product.id, quantity: 2 }
    assert_redirected_to cart_path
    
    # Place order
    get new_order_path
    assert_response :success
    
    post orders_path, params: { order: { delivery_address: '123 Test St', contact_number: '555-0123' } }
    assert_redirected_to order_path(Order.last)
    
    @product.reload
    assert_equal 5, @product.stock_quantity, "Stock should NOT be reduced at order creation"
    
    order = Order.last
    assert_equal "pending", order.status
    
    sign_out @customer
    
    # Admin approval
    sign_in @admin
    patch approve_admin_order_path(order), params: { expected_delivery_date: Date.tomorrow }
    assert_redirected_to admin_order_path(order)
    
    order.reload
    assert_equal "approved", order.status
    assert_not_nil order.expected_delivery_date
    
    @product.reload
    assert_equal 3, @product.stock_quantity, "Stock SHOULD be reduced on admin approval"
  end

  test "admin cannot approve order if stock is insufficient" do
    sign_in @customer
    post cart_items_path, params: { product_id: @product.id, quantity: 4 }
    post orders_path, params: { order: { delivery_address: '123 Test St', contact_number: '555-0123' } }
    order = Order.last
    sign_out @customer
    
    # Another customer buys out the stock
    @product.update!(stock_quantity: 2)
    
    sign_in @admin
    patch approve_admin_order_path(order), params: { expected_delivery_date: Date.tomorrow }
    assert_redirected_to admin_order_path(order)
    
    order.reload
    assert_equal "pending", order.status
    @product.reload
    assert_equal 2, @product.stock_quantity
  end
end
