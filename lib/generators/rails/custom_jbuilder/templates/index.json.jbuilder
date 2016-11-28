json.draw params[:draw].to_i
json.recordsTotal <%= singular_table_name.titleize %>.all.size
json.recordsFiltered @filtered<%= plural_table_name.titleize %>.size
json.data @<%= plural_table_name %>, partial: '<%= plural_table_name %>/<%= singular_table_name %>', as: :<%= singular_table_name %>