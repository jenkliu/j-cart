class ProductsController < ApplicationController
  before_filter :require_admin_auth, :only => [:admin_view, :new, :edit, :create, :udpate, :destroy]
  layout "admin", :only => [:admin_view, :new, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json
  # display product catalog for shoppers
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/admin
  # display product information for admin
  # requires: admin is logged in
  def admin_view
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  # display information for individual product
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  # display form to create a new product
  # requires: Admin is logged in
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  # displays form to edit product
  # requires: Admin is logged in, product with id exists
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  # requires: Admin is logged in, :product param is defined
  # modifies: products (if validation passes)
  # effects: new product is created (if validation passes)
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_url, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else # save fails due to validation error -> show errors
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  # requires: Admin is logged in, product with id exists
  # modifies: product
  # effects: product is updated with new attributes, else errors are displayed
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else # update fails due to validation error -> show errors
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  # requires: Admin is logged in, product with id exists
  # modifies: products
  # effects: deletes product from catalog
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product has been deleted.' }
      format.json { head :no_content }
    end
  end


  # GET /products/1/add_to_cart
  # adds 1 of product to cart, or alerts user if product is out of stock
  # requires: product with id exists
  # modifies: cart, product (if product in stock)
  # effects:
  # => if product is in stock:
  # =>    identifies cart if it exists in session, otherwise creates new one
  # =>    if product is already in the cart, increment the quantity
  # =>    otherwise create a new Item object with quantity 1 associated with this cart
  def add_to_cart
    @product = Product.find(params[:id])
    # alert user if product is out of stock
    if @product.qty_in_stock == 0
      flash[:notice] = "Sorry, " + @product.name + " is currently out of stock. Please check back soon!"
    else
      # check if a cart already exists in the session
      if cookies[:cart_id]
        @cart = Cart.find_by_id(cookies[:cart_id])
      else # if not, create a new cart
        @cart = Cart.create(:status => 'current')
        cookies[:cart_id] = @cart.id
        # if user is logged in, associate cart with that user
        if logged_in?
          @cart.attach_to_user(@current_user.id)
        end
      end
        
      # check if item already exists in cart      
      @item = @cart.items.where(:product_id => @product.id).first
      if @item.blank? #if not, create a new item
        @item = @cart.items.create(:product_id => @product.id, :name => @product.name, 
          :price => @product.price, :qty => 0)
      end
      @item.add

      # TODO: give the cookie an expiration date so that the product can be restored if not bought?
      flash[:notice] = @product.name + " has been added to your cart."
    end
    # stay in the same view
    redirect_to :controller => 'products', :action => 'show', :id => @product.id
  end
end
