class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update]
    before_action :set_products, only: [:index]
    
    # GET /products
    def index
        @columnConfig=@columnsData.map {|item|
            {  :title=>item,
               :data=> item,
               :visiable=>model_config_enable?(item,"visiable"),
               :orderable=>model_config_enable?(item,"orderable"),
               :searchable=>model_config_enable?(item,"searchable"),
               :render=>model_config_enable?(item,"render")
            }
        }.to_json
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
        # 从配置中拿到model有关dataTable的某些配置
        # 貌似比较好的方式是取到一次@columnsData就把它缓存起来?
        @model_config=Rails.configuration.model_config['product']
        @columnsData=Product.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end  
        if request.format.to_sym == :json
            # 解析dataTable传上来的参数
            columns=params[:columns]
            order=params[:order]["0"]
            search_value=params[:search][:value] #搜索框里的值
        
            # 允许搜索的项目,配置项在config/model_config/product.yml
            # search_list也换存起来?
            search_list=Product.attribute_names.select do |item|
                !@model_config[item].nil? && @model_config[item]["searchable"]
            end
            @filteredProducts=Product.all
        
            #如果有搜索项并且搜索框里有值,就进行字符串匹配
            if !search_list.empty? && !search_value.nil? && search_value.length > 0 
                @filteredProducts=Product.where(search_list.join(" like '%#{search_value}%' or ")+" like '%#{search_value}%'")
            end
        
            #排序
            @filteredProducts=@filteredProducts.order("#{columns[order["column"]]["data"]} #{order["dir"]}")  
            
            #分页
            @products=@filteredProducts.offset(params[:start]).limit(params[:length])
        end
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
        params.require(:product).permit(:title, :content)
    end

    def model_config_enable?(attribute,name)
        @model_config[attribute].nil? ? false : (false || @model_config[attribute][name])
    end
end
