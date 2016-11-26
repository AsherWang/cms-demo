class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    include Pundit
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    
    
    # 捕获Punnit的异常之后设置提示信息并重定向回去
    rescue_from Pundit::NotAuthorizedError do |exception|
        flash[:alert] = "此操作无权限"
        redirect_to :back
    end
    
    
end
