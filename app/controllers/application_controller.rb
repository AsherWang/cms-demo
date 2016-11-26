class ApplicationController < ActionController::Base
    layout :layout_by_resource
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    include Pundit
    protect_from_forgery with: :exception
    before_action :authenticate_admin!
    
    
    # 捕获Punnit的异常之后设置提示信息并重定向回去
    rescue_from Pundit::NotAuthorizedError do |exception|
        flash[:alert] = "此操作无权限"
        redirect_to :back
    end
    

    protected

    def pundit_user
        current_admin
    end
    
    def layout_by_resource
        p action_name
        if devise_controller? && resource_name == :admin && action_name == "new"
            "devise"
        else
            "application"
        end
    end
    
end
