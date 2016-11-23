class Rails::AsherGenerator < Rails::Generators::NamedBase
    # source_root File.expand_path("../templates", __FILE__)

    # 还不清楚怎么重载,先加一个route
    def add_route
        route "get '/#{file_name.pluralize}/index/ajax_data',to:'#{file_name.pluralize}#index_ajax'"
    end
end
