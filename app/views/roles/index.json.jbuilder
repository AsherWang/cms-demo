json.draw params[:draw].to_i
json.recordsTotal Role.all.size
json.recordsFiltered @filteredRoles.size
json.data @roles, partial: 'roles/role', as: :role