class ProductsController < ApplicationController
  require 'pry' 
  def index
    @products  = current_user.products
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def new
    @product = current_user.products.new  
  end

  def create
    @product = current_user.products.new(product_params)
    
    if @product.save
      redirect_to '/products'
    else
      render :new
    end

  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
    
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy

    redirect_to :index
  end

  private
    def product_params
      params.require(:product).permit(:title, :sub_title, :description, :price, :rating, :product_image)
    end
end
