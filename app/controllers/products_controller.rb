class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_products, only: [:index_ajax]
    # GET /products
    def index
        @products = Product.all
    end

    # GET /products/index/ajax
    def index_ajax
        @products = Product.all
    end


    # GET Index /products
    def index_ajax

        render json: {
            total: Product.all.all.size,
            data: @products.map{|item|item.attributes}  #todo:需要进行数据的过滤和格式化
        }
    end

    # GET /products/1
    def show
    end

    # GET /products/new
    def new
        @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to @product, notice: 'Product was successfully created.'
        else
            render :new
        end
    end

    # PATCH/PUT /products/1
    def update
        if @product.update(product_params)
            redirect_to @product, notice: 'Product was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /products/1
    def destroy
        @product.destroy
        redirect_to products_url, notice: 'Product was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.find(params[:id])
    end

    #set items for query
    def set_products
        @products = Product.all
        offset= !params[:offset].nil? ? params[:offset] : 0
        limit= !params[:limit].nil? ? params[:limit] : 200
        @products=Product.all.offset(offset).limit(limit)
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
        params.require(:product).permit(:title, :content)
    end
end
