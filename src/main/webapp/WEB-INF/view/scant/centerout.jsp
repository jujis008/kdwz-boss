<%@ page contentType="text/html;charset=UTF-8"
         trimDirectiveWhitespaces="true" %>
<%@include file="/tag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="/scripts/jquery-auto.js"></script> 
<script>
var $jqq = jQuery.noConflict(true);
</script> 
<script type="text/javascript" src="/scripts/jquery.autocomplete.js"></script>
    <script type="text/javascript">

    $(function () {
            trHover('t2');
         $('#reload_btn').click(function(){
       		 location.reload();
       	});
         var $inp = $('input:text');
         var piao = 0 ;
         $inp.bind('keydown', function (e) {
         	 if(e.which == 13) {
            		    e.preventDefault();
            		    var idv = $(this).attr("id") ; 
                       var nxtIdx = $inp.index(this) + 1;
                       if("lgcOrderNo"==idv){
                    	   var nextNo =  $('input[name=nextNo]').val() ;
                    	   var sendNo =  $('input[name=sendNo]').val() ;
                    	   var  lgcOrderNo = $(this).val();
                    	   if(nextNo.length<1){
                    		   alert("请输入下一站");
                    		   $('input[name=nextNo]').focus(); 
                    		   return ;
                    	   }
                    	   if(lgcOrderNo.length<1){
                    		   alert("请输入运单号");
                    		   $(this).focus(); 
                    		   return ;
                    	   }
                    	   
                    	   $.ajax({
                	   			 type: "post",//使用get方法访问后台
                	   	            dataType: "json",//返回json格式的数据
                	   	            url: "${ctx}/scant/center_out_save",//要访问的后台地址
                	   	            data: {'lgcOrderNo':lgcOrderNo,'nextNo':nextNo,'sendNo':sendNo},//要发送的数据
                	   	            success: function(data){//msg为返回的数据，在这里做数据绑定
                	   	            	if(data.ret==1){
                	   	            	 var html = '<tr>' ;
                	   	            	    html += '<td align="center">'+data.track.orderTime+'</td>';
                	   	            	    html += '<td align="center">'+lgcOrderNo+'</td>';
                	   	            	    html += '<td align="center">'+data.itemStatus+'</td>';
                	   	            	    html += '<td align="center">'+data.track.nextNo+'</td>';
                	   	            	    html += '<td align="center">'+data.track.nextType+'</td>';
                	   	                    html += '<td align="center">'+data.track_sendNo+'</td>';
                	   	                    html += '<td align="center">'+data.track_sendName+'</td>';
              	   	                        html += '<td align="center">'+data.track.scanOno+'</td>';
              	   	                        html += '<td align="center">'+data.track.scanOname+'</td>';
                	   	                    html += '</tr>';
                	   	                    $("#tb1").prepend(html) ; 
                	   	                    piao = piao +1 ;
                	   	                 $('.piao').html(piao);
                	   	            	}else if(data.ret==2){
                	   	            	 $('#tips').html(lgcOrderNo+data.msg);
                	   	            	}else{
                	   	            	alert(data.ret);
                	   	            }
                	   	        }
                	   		 }); 
                    	   
                    	  $('input[name=lgcOrderNo]').val("");	  
                    	  $('input[name=lgcOrderNo]').focus(); 
                       }else{
                    	   $(":input:text:eq(" + nxtIdx + ")").focus(); 
                       }
              }  
         });
         
     	jQuery.ajax({
		      url: '/codfile/tmjs/${lgcConfig.key}/${lgcConfig.curName}_${cmenu_sub_limit}.js',
		      dataType: "script",
		      cache: true
		}).done(function() {
        var slist =  tmjs.slist ;
         	var slists = [];
             $.each(slist, function(i, item) {
             	var inner_no = "" ;
             	if(item.inner_no){inner_no=item.inner_no+','}
             	slists[i]=item.substation_no.replace(/\ /g,"")+'('+inner_no+item.substation_name.replace(/\ /g,"")+')';
             });
             val1 = '';
               $jqq("#nextNo").autocomplete(slists, {
            		minChars: 0,
            		max: 12,
            		autoFill: true,
            		mustMatch: false,
            		matchContains: true,
            		scrollHeight: 220,
            		formatItem: function(slists, i, total) {
            			return slists[0];
            		}
            	}).result(function(event, data, formatted) {
             		if(data[0].indexOf(')')>-1){
            			 $("#nextNo").val(data[0]) ;
      			       } 
            	});	
     	
               $jqq("#sendNo").autocomplete(slists, {
           		minChars: 0,
           		max: 12,
           		autoFill: true,
           		mustMatch: false,
           		matchContains: true,
           		scrollHeight: 220,
           		formatItem: function(slists, i, total) {
           			return slists[0];
           		}
           	}).result(function(event, data, formatted) {
            		if(data[0].indexOf(')')>-1){
           			 $("#sendNo").val(data[0]) ;
     			       } 
           	});	
 });
    

         
 });
        
        

    </script>
</head>
<body>
<div class="search">
<div class="tableble_search">
        <div class=" search_cont">
     <input type="hidden" name="serviceName" value=""/>
        <ul style="width: 560px;">
             <li style="width: 80%;"><span style="color: red;">*&nbsp;</span>下一站：<input type="text" name="nextNo" id="nextNo" style="width: 250px;"></input></li>
             <li style="width: 80%;">派件网点：<input type="text" name="sendNo" id="sendNo" style="width: 250px;"></input></li>
             <li style="width: 80%;">&#12288;运单号：<input type="text" name="lgcOrderNo" id="lgcOrderNo" style="width: 250px;"></input>&nbsp;&nbsp;&nbsp;&nbsp;按回车确定</li>
        </ul>
         <div style="padding: 30px 0 ;font-size: 22px;">当前扫描票数：<span style="color: red;" class="piao">0</span></div>
  </div>   <!-- search_cont end  -->
    <div class="clear"></div>
 </div>   <!-- tableble_search end  -->   
  <div class="tableble_search">
  

   </div>   <!-- tableble_search end  -->   
  
</div>


<div class="tbdata">
    <table width="100%" cellspacing="0" class="t2" id="t2">
        <thead>
        <tr>
            <th width="6%" align="center">扫描时间</th>
            <th width="6%" align="center">运单号</th>
            <th width="6%" align="center">物品类型</th>
            <th width="6%" align="center">下一站编号</th>
            <th width="12%" align="center">下一站</th>
            <th width="12%" align="center">派件网点编号</th>
            <th width="12%" align="center">派件网点</th>
            <th width="12%" align="center">扫描员编号</th>
            <th width="12%" align="center">扫描员</th>
        </tr>
        </thead>
        <tbody id="tb1">
        </tbody>
    </table>
</div>
</body>

</html>