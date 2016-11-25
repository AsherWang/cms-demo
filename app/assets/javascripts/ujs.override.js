(function($){
    //Override the default confirm dialog by rails
    $.rails.allowAction = function(link){
        console.log(link.data("confirm"));
        if (link.data("confirm") == undefined){
            console.log("return here");
            return true;
        }
        $.rails.showConfirmationDialog(link);
        return false;
    };
//User click confirm button
    $.rails.confirmed = function(link){
        //link.removeAttr("data-confirm");
        link.data("confirm",null);
        var dataTableSelector="#"+link.parents("table").attr("id");
        var dataTable= $.dataTablesTables[dataTableSelector];
        dataTable.destroy([link.attr("href").match(/\/(\d+)$/)[1]]);  //后续在datatable.method.js
    };
//Display the confirmation dialog
    $.rails.showConfirmationDialog = function(link){
        
        var message = link.data("confirm");
        $.showConfirmDialog("确认",message,function(){
            $.rails.confirmed(link);
        },function(){
            //Cancel
        });
    };
    
    
    
}(jQuery));
