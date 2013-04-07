require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:shoes)
    @bob = users(:bob)
    cookies[:user_id] = @bob.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { brand: @product.brand, info: @product.info, name: @product.name, price: @product.price, qty_in_stock: @product.qty_in_stock }
    end

    assert_redirected_to admin_products_path
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { brand: @product.brand, info: @product.info, name: @product.name, price: @product.price, qty_in_stock: @product.qty_in_stock }
    assert_redirected_to admin_products_path
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  test "should add to empty cart" do
    cookies[:cart_id] = nil   
    
    assert_difference('Item.count') do
      get :add_to_cart, product_id: @product
    end
    
    assert cookies[:cart_id] != nil

    assert_equal @product.name + " has been added to your cart.", flash[:notice]
    assert_redirected_to product_path(@product)
  end

  test "should add to existing item in cart" do
    cookies[:cart_id] = 1
    assert_no_difference('Item.count') do
      get :add_to_cart, product_id: @product
    end
  end


end
