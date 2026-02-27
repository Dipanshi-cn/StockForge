require "test_helper"

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_orders_show_url
    assert_response :success
  end

  test "should get approve" do
    get admin_orders_approve_url
    assert_response :success
  end

  test "should get reject" do
    get admin_orders_reject_url
    assert_response :success
  end
end
