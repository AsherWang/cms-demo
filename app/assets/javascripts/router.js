;(function ($) {
    var regExp = {
        edit: /^\/[^\/]+\/[^\/]+\/edit(\?\.*)?/,
        new:/^\/[^\/]+\/new(\?\.*)?/,
        show: /^\/[^\/]+\/[^\/]+(\?\.*)?/,
        index: /^\/[^\/]+(\?\.*)?/
        
    };
    
    function check_action_run(name,controller,action){
        var func= $.MM_controller[name];
        if(func){func(controller,action);}
    }
    
    function call_controller_action(controller,action){
        console.log(controller+"#"+action);
        
        //before_action
        check_action_run("_"+controller+"_"+action);
        
        //action
        check_action_run(controller+"_"+action);
        
        //after_action
        check_action_run(controller+"_"+action+"_");
        
    }

    $.MM_router = {};
    $.MM_controller = {};
    
    $(document).ready(function () {
        var matched=false;
        $.each(regExp,function(key,value){
            if(matched)return;
            if(value.test(location.pathname)){
                var controller=location.pathname.match(/^\/[^\/]+/).toString().substring(1);
                call_controller_action(controller,key);
                matched=true;
            }
        });

    });
}(jQuery));