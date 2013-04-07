class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_cart, :cart_qty, :current_user

  private
    def cart_qty
    	if cookies[:cart_id] && Cart.find(cookies[:cart_id])
    		@cart_qty = Cart.find_by_id(cookies[:cart_id]).items.sum(:qty)
    	else
    		@cart_qty ||= 0
    	end
    end


    def current_user
      @current_user ||= cookies[:user_id] && User.find_by_id(cookies[:user_id])
    end

    def current_cart
      @current_cart ||= cookies[:cart_id] && Cart.find_by_id(cookies[:cart_id])
    end
    
    # TODO: should be in helper method AND before filter?
    helper_method :current_user, :current_cart, :cart_qty, :logged_in?
 
  def logged_in?
    !!current_user
  end


  def return_to
    cookies[:return_to] ||= request.referer
  end

  def require_user_login
    unless logged_in?
      flash[:error] = "Please log in before continuing."
      redirect_to login_url
    end
  end

  def require_admin_auth
    if logged_in?
      if current_user.type == "Admin"
        @auth_admin = true
      else
        @auth_admin = false
        flash.now[:error] = "Oops! You do not have permission to view this page."
      end
    else
      redirect_to login_url
    end
  end



end
