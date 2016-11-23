class InitializerGenerator < Rails::Generators::Base

    desc "This generator created by extra_route creates an initializer file at config/initializers"
    def create_initializer_file
        create_file "config/initializers/initializer.rb", "# Add initialization content here"
    end

#     类似于rake任务
end