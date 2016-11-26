class UsersController < ApplicationController
    before_action :set_model_config, only:[:index,:index_ajax]
    before_action :set_user, only: [:show, :edit, :update]
    before_action :set_users, only: [:index_ajax]
    
    # GET /users
    def index
        @users = User.all
    end


    # GET Index /users
    def index_ajax
         render json: {
            draw:params[:draw].to_i,
            recordsTotal: User.all.size,
            recordsFiltered: @filteredUsers.size,
            data: @users.map{|item|item.attributes}  #todo:需要进行数据的过滤和格式化
        }


    end

    # GET /users/1
    def show
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to @user, notice: 'User was successfully created.'
        else
            render :new
        end
    end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
            redirect_to @user, notice: 'User was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /users/1
    # DELETE
    def destroy
        User.destroy_all(:id=>params[:ids])
       
        render :json=>nil,:status=>204
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    #set items for query
    #
    def set_users
        
        columns=params[:columns]
        order=params[:order]["0"]
        search_list=User.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["searchable"]
        end
        @filteredUsers=User.all
        @filteredUsers=@filteredUsers.order("#{columns[order["column"]]["data"]} #{order["dir"]}")  #单项排序
        @users=@filteredUsers.offset(params[:start]).limit(params[:length])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
        params.require(:user).permit(:username)
    end

    def set_model_config
        @model_config=Rails.configuration.model_config['user']
        @columnsData=User.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end
    end
end
