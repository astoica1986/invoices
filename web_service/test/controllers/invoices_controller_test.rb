require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get invoices_path('google')
    assert_response :success
  end

  test "should get index" do
    get invoices_path
    assert_response :success
  end

end
