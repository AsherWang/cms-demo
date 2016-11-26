<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
    before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update]
    before_action :set_<%= plural_table_name %>, only: [:index]
    
    # GET <%= route_url %>
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

    # GET <%= route_url %>/1
    def show
    end

    # GET <%= route_url %>/new
    def new
        @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    end

    # GET <%= route_url %>/1/edit
    def edit
    end

    # POST <%= route_url %>
    def create
        @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

        if @<%= orm_instance.save %>
            redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully created.'" %>
        else
            render :new
        end
    end

    # PATCH/PUT <%= route_url %>/1
    def update
        if @<%= orm_instance.update("#{singular_table_name}_params") %>
            redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully updated.'" %>
        else
            render :edit
        end
    end

    # DELETE <%= route_url %>/1
    # DELETE
    def destroy
        <%= singular_table_name.titleize %>.destroy_all(:id=>params[:ids])
       
        render :json=>nil,:status=>204
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
        @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    #set items for query
    #
    def set_<%=plural_table_name %>
        # 从配置中拿到model有关dataTable的某些配置
        # 貌似比较好的方式是取到一次@columnsData就把它缓存起来?
        @model_config=Rails.configuration.model_config['<%= singular_table_name %>']
        @columnsData=<%= singular_table_name.titleize %>.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end  
        if request.format.to_sym == :json
            # 解析dataTable传上来的参数
            columns=params[:columns]
            order=params[:order]["0"]
            search_value=params[:search][:value] #搜索框里的值
        
            # 允许搜索的项目,配置项在config/model_config/<%= singular_table_name%>.yml
            # search_list也换存起来?
            search_list=<%= singular_table_name.titleize %>.attribute_names.select do |item|
                !@model_config[item].nil? && @model_config[item]["searchable"]
            end
            @filtered<%= plural_table_name.titleize %>=<%= orm_class.all(class_name) %>
        
            #如果有搜索项并且搜索框里有值,就进行字符串匹配
            if !search_list.empty? && !search_value.nil? && search_value.length > 0 
                @filtered<%= plural_table_name.titleize %>=<%= singular_table_name.titleize %>.where(search_list.join(" like '%#{search_value}%' or ")+" like '%#{search_value}%'")
            end
        
            #排序
            @filtered<%= plural_table_name.titleize %>=@filtered<%= plural_table_name.titleize %>.order("#{columns[order["column"]]["data"]} #{order["dir"]}")  
            
            #分页
            @<%= plural_table_name %>=@filtered<%= plural_table_name.titleize %>.offset(params[:start]).limit(params[:length])
        end
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
        params[:<%= singular_table_name %>]
    <%- else -%>
        params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
    end

    def model_config_enable?(attribute,name)
        @model_config[attribute].nil? ? false : (false || @model_config[attribute][name])
    end
end
<% end -%>
