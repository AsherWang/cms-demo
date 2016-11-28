class Rails::ModelConfigGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    
    def copy_model_config_file
        copy_file "model.yml", "config/model_config/#{plural_name.singularize}.yml"
    end
    
    hook_for :javascripts
end
