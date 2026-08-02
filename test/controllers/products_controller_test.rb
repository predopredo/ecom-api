require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("data")
    assert json_response.key?("meta")
    assert_equal 1, json_response["meta"]["page"]
    assert_equal 20, json_response["meta"]["per_page"]
    assert_not_nil response.headers["X-Total-Count"]
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { description: @product.description, name: @product.name, price: @product.price, sku: @product.sku, stock: @product.stock } }, as: :json
    end

    assert_response :created
  end

  test "should show product" do
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price: @product.price, sku: @product.sku, stock: @product.stock } }, as: :json
    assert_response :success
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end

    assert_response :no_content
  end
end
