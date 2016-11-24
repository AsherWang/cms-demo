module ActionDispatch::Routing
    class Mapper
        Resources.module_eval do
            #     # Sometimes, you have a resource that clients always look up without
            #     # referencing an ID. A common example, /profile always shows the
            #     # profile of the currently logged in user. In this case, you can use
            #     # a singular resource to map /profile (rather than /profile/:id) to
            #     # the show action:
            #     #
            #     #   resource :profile
            #     #
            #     # creates six different routes in your application, all mapping to
            #     # the +Profiles+ controller (note that the controller is named after
            #     # the plural):
            #     #
            #     #   GET       /profile/new
            #     #   POST      /profile
            #     #   GET       /profile
            #     #   GET       /profile/edit
            #     #   PATCH/PUT /profile
            #     #   DELETE    /profile
            #     #
            #     # === Options
            #     # Takes same options as +resources+.
            #     def resource(*resources, &block)
            #         options = resources.extract_options!.dup
            # 
            #         if apply_common_behavior_for(:resource, resources, options, &block)
            #             return self
            #         end
            # 
            #         resource_scope(:resource, SingletonResource.new(resources.pop, options)) do
            #             yield if block_given?
            # 
            #             concerns(options[:concerns]) if options[:concerns]
            # 
            #             collection do
            #                 post :create
            #             end if parent_resource.actions.include?(:create)
            # 
            #             new do
            #                 get :new
            #             end if parent_resource.actions.include?(:new)
            # 
            #             set_member_mappings_for_resource
            #         end
            # 
            #         self
            #     end
            # 
                def resources(*resources, &block)
                    options = resources.extract_options!.dup
            
                    if apply_common_behavior_for(:resources, resources, options, &block)
                        return self
                    end
            
                    resource_scope(:resources, Resource.new(resources.pop, options)) do
                        yield if block_given?
            
                        concerns(options[:concerns]) if options[:concerns]
            
                        collection do
                            get :index if parent_resource.actions.include?(:index)
                            # todo: map action index_ajax to a specific url pattern
                            get :index_ajax
                            post :create if parent_resource.actions.include?(:create)
                        end
            
                        new do
                            get :new
                        end if parent_resource.actions.include?(:new)
            
                        set_member_mappings_for_resource
                    end
            
                    self
                end
            # 
            # 
        end
    end
end
