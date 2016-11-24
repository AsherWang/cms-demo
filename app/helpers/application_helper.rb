module ApplicationHelper
    def alert_helper(info,type)
        ret=""
        if info
            ret+="<p id='#{type}' class='alert alert-#{type} alert-dismissable' style='margin-bottom: 10px;'>"
            ret+="<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>"
            ret+=info
            ret+="</p>"
        end
        ret
    end
    

    def panel_helper(title,&block)
        ret="<div class='row'><div class='col-lg-12'><div class='panel panel-default'><div class='panel-heading'>#{title}</div>"
        ret+="<div class='panel-body'>#{with_output_buffer(&block)}</div></div></div>"
    end


end
