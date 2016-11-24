(function($){
    methods={
        destroy:function(url,csrfToken,ids,cb){
            $.ajax(url,{
                data:{
                    "authenticity_token":csrfToken,
                    "_method":"DELETE",
                    "ids":ids
                },
                method:"POST"
            }).always(function(data,content,response){
                cb(response.status==204,response.status);
            });
        }
    };
    
    $.MM_dataTable=function(selector,dataTablesOptions,urls){
        var csrfToken=$("meta[name='csrf-token']").attr("content");  //构造请求的时候需要用
        var data=$.extend($.dataTableDefaultConfiguration,{
            "ajax": {
                "url":urls.query,
                "type": "GET",
                "dataSrc": "data"
            }
        },dataTablesOptions);  //databales的配置文件
        var table=$(selector);
        
        //初始化
        table.DataTable(data);
        
        //绑定事件
        table.find("#dataTableSelectAll").click(function(){
            var flag=this.checked;
            $(selector+" .itemSelector").each(function(){this.checked=flag;});
        });
        
        var gatherSelectedItemId=function(){
            var ret=[];
            $(selector+" .itemSelector[name=item]").each(function(){
                if(this.checked){ret.push($(this).attr("item-id"));}
            });
            return ret;
        };
        
        
        $("#mutipleDeleteBtn").click(function(){
            //show alert
            methods.destroy(urls.delete,csrfToken,gatherSelectedItemId(),function(success,status){
                if(success){
                    //todo:删除成功,如果与此同时没有另一个人新加一个记录的话,这里可以直接从dom中remove掉而不需要刷新
                    //嘛暂时先刷新页面
                    location.reload();
                }else{
                    //删除失败
                    if(status==401){
                        alert("无权操作");
                    }
                }
            });
        });
        
        return {
                "info":"nothing"
        };
    }
}(jQuery));