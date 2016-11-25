class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update]
    before_action :set_products, only: [:index_ajax]
    before_action :set_model_config, only:[:index,:index_ajax]
    # GET /products
    def index
        
    end

    
    # GET Index /products
    def index_ajax
        render json: {
            draw:params[:draw].to_i,
            recordsTotal: Product.all.size,
            recordsFiltered: @filteredProducts.size,
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
    # DELETE
    def destroy
        Product.destroy_all(:id=>params[:ids])
       
        render :json=>nil,:status=>204
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.find(params[:id])
    end

    #set items for query
    #
    def set_products
        @filteredProducts=Product.all
        @products=@filteredProducts.offset(params[:start]).limit(params[:length])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
        params.require(:product).permit(:title, :content)
    end
    
    def set_model_config
        @model_config=Rails.configuration.model_config['product']
        @columnsData=Product.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end
    end
end
