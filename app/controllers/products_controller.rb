# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_main_image.all
  end

  def show
    @product = Product.with_attached_additional_images.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, 
      :description, 
      :price, 
      :stock,
      :main_image,
      :manual,
      additional_images: []
    )
  end
end
