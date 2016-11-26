class StoriesController < ApplicationController
    before_action :check_permission
    before_action :set_model_config, only:[:index,:index_ajax]
    before_action :set_story, only: [:show, :edit, :update]
    before_action :set_stories, only: [:index_ajax]
    
    # GET /stories
    def index
        @stories = Story.all
    end


    # GET Index /stories
    def index_ajax
         render json: {
            draw:params[:draw].to_i,
            recordsTotal: Story.all.size,
            recordsFiltered: @filteredStories.size,
            data: @stories.map{|item|item.attributes}  #todo:需要进行数据的过滤和格式化
        }


    end

    # GET /stories/1
    def show
    end

    # GET /stories/new
    def new
        @story = Story.new
    end

    # GET /stories/1/edit
    def edit
    end

    # POST /stories
    def create
        @story = Story.new(story_params)

        if @story.save
            redirect_to @story, notice: 'Story was successfully created.'
        else
            render :new
        end
    end

    # PATCH/PUT /stories/1
    def update
        if @story.update(story_params)
            redirect_to @story, notice: 'Story was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /stories/1
    # DELETE
    def destroy
        Story.destroy_all(:id=>params[:ids])
       
        render :json=>nil,:status=>204
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
        @story = Story.find(params[:id])
    end

    #set items for query
    #
    def set_stories
        p params
        columns=params[:columns]
        order=params[:order]["0"]
        search_value=params[:search][:value] #搜索框里的值
    
        # 允许搜索的项目,配置项在config/model_config/story.yml
        search_list=Story.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["searchable"]
        end
        @filteredStories=Story.all
    
        #如果有搜索项并且搜索框里有值,就进行字符串匹配
        if !search_list.empty? && !search_value.nil? && search_value.length > 0 
            @filteredStories=Story.where(search_list.join(" like '%#{search_value}%' or ")+" like '%#{search_value}%'")
        end
    
        #排序
        @filteredStories=@filteredStories.order("#{columns[order["column"]]["data"]} #{order["dir"]}")  
        
        #分页
        @stories=@filteredStories.offset(params[:start]).limit(params[:length])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
        params.require(:story).permit(:title, :content)
    end

    def set_model_config
        @model_config=Rails.configuration.model_config['story']
        @columnsData=Story.attribute_names.select do |item|
            !@model_config[item].nil? && @model_config[item]["visiable"]
        end
    end
    
    def check_permission
        p 'permission text'
        p params["controller"]+"_"+params["action"]
        # unless current_admin.permissions.include?(params["controller"]+"_"+params["action"])
        #     raise "没权限啦"
        # end
    end
end
