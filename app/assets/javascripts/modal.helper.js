(function($){
    function showConfirmDialog(title,content,confirmCb,cancelCb){
        $("#comfirmDialogLabel").text(title);
        $("#comfirmDialogContent").text(content);
        $("#comfirmDialogConfirmBtn").unbind().click(function(){
            confirmCb();
            $("#comfirmDialog").modal("hide");
        });
        if(cancelCb)$("#comfirmDialogCancelBtn").unbind().click(function(){
            cancelCb();
        });
        $("#comfirmDialog").modal();
    }
    
    $.showConfirmDialog=showConfirmDialog;
}(jQuery));