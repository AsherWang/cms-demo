(function($){
    
    //一个保存了全局dataTable的Table
    $.dataTablesTables={};
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
                cb(ids,response.status==204,response.status);
            });
        }
    };
    
    $.MM_dataTable=function(name,dataTablesOptions){
        //todo:先移进来,回去再重构这里好了
        var selector="#"+name+"DataTables";
        var config=$("#"+name+"DataTablesConfig");
        var baseUrl=config.data("base-url");
        var urls={
            query:baseUrl+'.json',
            delete:baseUrl+'/2333'
        };
        var columns=[];
        columns.push({"title":"<input type='checkbox' class='dataTableSelectAll' />","className":"dataTableSelection","orderable":false,"searchable":false,"data":"id",render:function(id){
            return "<input type='checkbox' class='itemSelector' name='item' item-id='"+id+"' />";
        }});

        config.data("column-config").forEach(function(item){
            item.render=$.dataTablesFormatters(item.render);
            columns.push(item);  //item的render这里有问题
        });
        columns.push({"title":"operations","orderable":false,"searchable":false,"data":"id",render:function(id){
            linkHref=+baseUrl+'/'+id;
            look="<a class='btn btn-sm btn-default' href='"+linkHref+"' style='margin-right:7px;'>详情</a>";
            edit="<a class='btn btn-sm btn-default' href='"+linkHref+"/edit' style='margin-right:7px;'>编辑</a>";
            del="<a data-confirm='确定删除?' rel='nofollow' data-method='delete' href="+linkHref+" class='btn btn-danger btn-sm'>删除</a>";
            return look+edit+del;
        }});
        var csrfToken=$("meta[name='csrf-token']").attr("content");  //构造请求的时候需要用
        var data=$.extend($.dataTableDefaultConfiguration,{
            "ajax": {
                "url":urls.query,
                "type": "GET",
                "dataSrc": "data"
            },
            "processing": true,
            "serverSide": true,
            "columns":columns
        });  //databales的配置文件
        var table=$(selector);
        
        //初始化
        var dataTableObject=table.DataTable(data);
        
        //绑定事件
        table.find(".dataTableSelectAll").click(function(){
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
        
        //删除某条数据之后的回调
        var deleteCb=function(ids,success,status){
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
        };
        $("#"+config.data("model")+"MutipleDeleteBtn").click(function(){
            //show alert
            var ids=gatherSelectedItemId();
            if(ids.length<1){
                return false;
            }
            $.showConfirmDialog("确认","确认删除"+(ids.length>1 ? "这"+ids.length+"项" : "")+"?",function(){
                methods.destroy(urls.delete,csrfToken,gatherSelectedItemId(),deleteCb);
            },function(){
                console.log("cancel");
            });
            
        });
        
        var ret= {
            "dataTableObject": dataTableObject,
            "destroy": function (ids) {
                methods.destroy(urls.delete, csrfToken, ids, deleteCb);
            }
        };
        $.dataTablesTables[selector]=ret;
        return ret;
        
    }
}(jQuery));