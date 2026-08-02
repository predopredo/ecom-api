class ProductsController < ApplicationController
  include Paginatable

  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    scope = Product.order(id: :asc)

    if params[:search].present?
      term = "%#{params[:search].downcase}%"
      scope = scope.where("LOWER(name) LIKE ? OR LOWER(sku) LIKE ? OR LOWER(description) LIKE ?", term, term, term)
    end

    render json: paginate(scope)
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_content
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :price, :description, :sku, :stock ])
    end
end
