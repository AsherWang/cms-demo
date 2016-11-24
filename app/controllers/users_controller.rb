class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :set_users, only: [:index_ajax]
    # GET /users
    def index
        @users = User.all
    end

    # GET /users/index/ajax
    def index_ajax
        @users = User.all
    end


    # GET Index /users
    def index_ajax
        render json: {
            total: User.all.all.size,
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
        # if params[:ids].include? current_user.id
        #     render :json=>nil,:status=>401
        # else
        #     User.destroy_all(:id=>params[:ids])
        #     render :json=>nil,:status=>204
        # end
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
        @users=User.all.offset(params[:offset]).limit(params[:limit])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
