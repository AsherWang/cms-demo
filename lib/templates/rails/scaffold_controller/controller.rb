<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
    before_action :set_model_config, only:[:index,:index_ajax]
    before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update]
    before_action :set_<%= plural_table_name %>, only: [:index_ajax]
    
    # GET <%= route_url %>
    def index
        @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    end


    # GET Index <%= route_url %>
    def index_ajax
         render json: {
            draw:params[:draw].to_i,
            recordsTotal: <%= orm_class.all(class_name) %>.size,
            recordsFiltered: @filtered<%= plural_table_name.titleize %>.size,
            data: @<%= plural_table_name %>.map{|item|item.attributes}  #todo:需要进行数据的过滤和格式化
        }


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
        
        columns=params[:columns]
        order=params[:order]["0"]
        search_list=<%= singular_table_name.titleize %>.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["searchable"]
        end
        @filtered<%= plural_table_name.titleize %>=<%= orm_class.all(class_name) %>
        @filtered<%= plural_table_name.titleize %>=@filtered<%= plural_table_name.titleize %>.order("#{columns[order["column"]]["data"]} #{order["dir"]}")  #单项排序
        @<%= plural_table_name %>=@filtered<%= plural_table_name.titleize %>.offset(params[:start]).limit(params[:length])
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
        params[:<%= singular_table_name %>]
    <%- else -%>
        params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
    end

    def set_model_config
        @model_config=Rails.configuration.model_config['<%= singular_table_name %>']
        @columnsData=<%= singular_table_name.titleize %>.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end
    end
end
<% end -%>
