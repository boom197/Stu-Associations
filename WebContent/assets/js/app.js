(function($) {
  'use strict';
  $(function() {
    var $fullText = $('.admin-fullText');
    $('#admin-fullscreen').on('click', function() {
      $.AMUI.fullscreen.toggle();
    });

    $(document).on($.AMUI.fullscreen.raw.fullscreenchange, function() {
      $fullText.text($.AMUI.fullscreen.isFullscreen ? '退出全屏' : '开启全屏');
    });
  });
})(jQuery);

//表单数据转JSON对象
(function($){  
$.fn.serializeForm=function(){  
	   var inputs=$(this).find("input,textarea,select");  
	   var o = {};  
	   $.each(inputs,function(i,n){  
	       switch(n.nodeName.toUpperCase()){  
	           case "INPUT":  
	           if($(n).is(":checkbox")){  
	               if($(n).is(":checked")){  
	                   o[n.name]=true;  
	               }else{  
	                   o[n.name]=false;  
	               }  
	           }else if($(n).is(":radio")){  
	               if($(n).is(":checked")){  
	                   o[n.name]=n.value;  
	               }  
	           }else{  
	               o[n.name]=n.value;   
	           }  
	
	           break;  
	       case "TEXTAREA":  
	           o[n.name]=$(n).text();  
	           break;  
	       case "SELECT":  
	                   o[n.name]=n.value;  
	                   break;  
	           }  
	       });  
	       return o;  
	   }
})(jQuery);

//表单加载JSON
$.fn.extend({
    //表单加载json对象数据
    setForm : function (jsonValue) {
        var obj = this;
        $.each(jsonValue, function (name, ival) {
            var $oinput = obj.find("input[name=" + name + "]");
            if ($oinput.attr("type") == "checkbox") {
                if (ival !== null) {
                    var checkboxObj = $("[name=" + name + "]");
                    var checkArray = ival.split(";");
                    for (var i = 0; i < checkboxObj.length; i++) {
                        for (var j = 0; j < checkArray.length; j++) {
                            if (checkboxObj[i].value == checkArray[j]) {
                                checkboxObj[i].click();
                            }
                        }
                    }
                }
            }
            else if ($oinput.attr("type") == "radio") {
                $oinput.each(function () {
                    var radioObj = $("[name=" + name + "]");
                    for (var i = 0; i < radioObj.length; i++) {
                        if (radioObj[i].value == ival) {
                            radioObj[i].click();
                        }
                    }
                });
            }
            else if ($oinput.attr("type") == "textarea") {
                obj.find("[name=" + name + "]").html(ival);
            }
            else {
                obj.find("[name=" + name + "]").val(ival);
            }
        })
    }
});