(function($){
    
    //格式化服务器端过来的日期数据
    function dateFormatter(date){
        date=new Date(date);
        var day = date.getDate();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var hour = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        return year+"/"+month+"/"+day+" "+hour+":"+min+":"+sec;
    }
    
    //格式化图片数据
    function picFormatter(imgUrl){
        return "<img class='dataTableImg' src='"+imgUrl+"' />";
    }
    
    
    
    $.dataTablesFormatters=function(dataType){
        switch(dataType){
            case "date": //日期
                return dateFormatter;
            case "picture":
                return picFormatter;
            default://如果没指定formatter,则直接返回
                return function(data){return data};

        }
    };

    
}(jQuery));