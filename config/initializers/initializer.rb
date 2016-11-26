# 重写resources方法,让它多开一个路由出来
#虽然当初折腾你挺费事的,可惜现在不需要你了

# module ActionDispatch::Routing
#     class Mapper
#         Resources.module_eval do
#                 def resources(*resources, &block)
#                     options = resources.extract_options!.dup
#             
#                     if apply_common_behavior_for(:resources, resources, options, &block)
#                         return self
#                     end
#             
#                     resource_scope(:resources, Resource.new(resources.pop, options)) do
#                         yield if block_given?
#             
#                         concerns(options[:concerns]) if options[:concerns]
#             
#                         collection do
#                             get :index if parent_resource.actions.include?(:index)
#                             get :index_ajax
#                             post :create if parent_resource.actions.include?(:create)
#                         end
#             
#                         new do
#                             get :new
#                         end if parent_resource.actions.include?(:new)
#             
#                         set_member_mappings_for_resource
#                     end
#             
#                     self
#                 end
#             # 
#             # 
#         end
#     end
# end


