<%@ page contentType="text/html;charset=UTF-8"
         trimDirectiveWhitespaces="true" %>
<%@include file="/tag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/header_01.jsp"%>
<link rel="stylesheet" href="${ctx}/themes/default/new_layout/table_new.css"/>
<link rel="stylesheet" href="${ctx}/themes/default/orderEdit.css"/>
<link rel="stylesheet" href="${ctx}/themes/default/track.css"/>
<script  type="text/javascript" src="/scripts/city_hp.js"></script>
<script type="text/javascript" src="/scripts/jquery-auto.js"></script> 
<script>
var $jqq = jQuery.noConflict(true);
</script> 
<script type="text/javascript" src="/scripts/jquery.autocomplete.js"></script>
<script type="text/javascript" src="/scripts/inputCheck.js"></script>
<style type="text/css">
.wi{ width:140px; text-align:right; margin-right:14px;}
.form_bottom ul li{ float:none;}
.yundan_in .yundan_input{ margin-top:8px;}
.yundan_in select{ margin-top:10px;}
.form_left{ width:44%;}
input.disbt{background: #C9C9C9;}

select {border: 1px solid #cdcdcd;	height: 28px;}
.select_a{	width:109px !important;margin-right: 10px;}
.select_a:nth-of-type(3) {	margin-right: 0;}
.select_b {	width: 180px;}
.check_cont_right02 .two{width: 346px !important;}
</style>

<script type="text/javascript">

function inputCheck1()
{
	 return false ;
} 
    function inputCheck()
    {
    	var lgcOrderNo = $('input[name=lgcOrderNo]').val();
		 if(lgcOrderNo.length<2){
			 alert('请输入快递公司运单号');
			 return false;
		 }
		 return true ;
    }

    function ChangeProvincel(objTip,objOption,provinceValue)
    {
    	ChangeProvince(objOption,provinceValue,provinceValue);
    }

    function ChangeCityl(objTip,objOption,provinceValue)
    {
    	ChangeCity(objOption,provinceValue,provinceValue);
    }

    function ChangeAreal(objTip)
    {
    }

    
        $(function () {
        	
            var exam = '${params.exam}';
        /*     if('pass'==exam){
               alert("审核通过的运单不允许修改！！！") ;
            } */
            
            
          	var areas = spit1('${orderMap.send_area}').split("-") ;
        	var rareas = spit1('${orderMap.rev_area}').split("-") ;
        	if(!areas[2]){
        			  InitOption('sprovince','scity','sarea','','');
        	}else{
        		 InitOption('sprovince','scity','sarea',areas[0],areas[1],areas[2]);
        	}
        	if(!rareas[2]){
           	  InitOption('rprovince','rcity','rarea','','');  
        	}else{
     	     InitOption('rprovince','rcity','rarea',rareas[0],rareas[1],rareas[2]);
  	        }    
            
            
            
        	$("#vf").validationEngine("attach",{
        		ajaxFormValidation:false,
        		onBeforeAjaxFormValidation:function (){
        			alert("before ajax validate");
        		},
        		onAjaxFormComplete:
                function (){
        			
        		}
        		
        	}); 
        	var lgcOrderNo = $('input[name=lgcOrderNo]').val();
   		    if(lgcOrderNo.length<1){
   			     $("#lgcOrderNo").focus();
        	 }else{
        		 $("#message").focus();
        	 }
        	
        	$(".cmount").on('input',function(e){  
        		
        		var vpay1 = $('input[name=vpay]').val() ;
        		var freight1 = $('input[name=freight]').val() ;
        		var good_price1 = $('input[name=good_price]').val() ;
        		var freight_type1 = $('input[name=freight_type]').val() ;
        		var payType1 = $('input[name=payType]').val() ;
        		
        		 if(!reg[6].test(vpay1)){
        			 vpay1 = 0 ;
        		 }
        		 if(!reg[6].test(freight1)){
        			 freight1 = 0 ;
        		 }
        		 if(!reg[6].test(good_price1)){
        			 good_price1 = 0 ;
        		 }
        		 var tnpay = 0 ;
        		 if(freight_type1=='1'||freight_type1=='寄方付'&&payType1.length>0){
        			 tnpay = freight1 - (-vpay1) ;
        				switch(payType1)
        				{
        				case '1':case '现金':case '3':case '会员卡':
        				 tnpay = freight1 - (-vpay1) ;
        				  break;
        				case '2':case '月结':
        					 tnpay =  freight1 - (-vpay1) ;
          				  break;
        				default:break;
        				}
        		 }
        		 if(freight_type1=='2'||freight_type1=='到方付'){
        			 tnpay = 0 ;
        		 }
        		
        		// amount = good_price1-(-cpay1)-(-vpay1)-(-freight1);
        		var  amount = good_price1-(-vpay1)-(-freight1);
        		var  v_amount = vpay1-(-freight1);
        		 $('input[name=tnpay]').val(tnpay) ;
                 $('input[name=payAcount]').val(amount) ;
                 $('input[name=v_amount]').val(v_amount) ; 
        		}); 
        	//////jhkhjkhjkhjkhj
        	
            var $inp = $('input:text');
            $inp.bind('keydown', function (e) {
            	 if(e.which == 13) {
              	   var isFocus=$(".pf").is(":focus");  
              	   if(isFocus){
              		   var  sPhone = $('input[name=sendPhone]').is(":focus");  
              		   var phone = $('input[name=sendPhone]').val() ;
              		   if(sPhone){
              			   if(phone.length<2){
              				   alert("请输入寄件人电话号码");
                  			   return ; 
              			   }
              			   $.dialog({lock: true,title:'地址簿',drag: true,width:800,height:470,resize: false,max: false,content: 'url:${ctx}/order/lgc_addr?inid=S&phone='+phone+'&layout=no',close: function(){
                           	 }});
              			   
              		   }else{
              			   phone = $('input[name=revPhone]').val() ;
              			   if(phone.length<2){
              				   alert("请输入收件人电话号码");
                  			   return ; 
              			   }
              			   $.dialog({lock: true,title:'地址簿',drag: true,width:800,height:470,resize: false,max: false,content: 'url:${ctx}/order/lgc_addr?inid=R&phone='+phone+'&layout=no',close: function(){
                           	 }}); 
              		   }
              	   }else{
              		   var idv = $(this).attr("id") ;  
              		   var nn = false ;
                       if(idv=='forNo'||idv=='orderNote'){
                    	   var mval = $('#monthSettleNo').val(); 
                    	      if(mval.indexOf(')')>-1){
                     			 $("#monthSettleNo").val(mval.substring(0,mval.indexOf('('))) ;
                     			 $("#monthSname").val(mval.substring(mval.indexOf('(')+1,mval.indexOf(')')));
               			       } else{
               			    	 _submit() ;
               			       }
                       }else{
                    	   var i = 1 ;
                      if(idv=='message'){
                    	   if($(this).val()=='0'||$(this).val()=='否'){
                    		   nn = true ;
                    		   i = 2 ;
                    	   }
                       }
                       if(idv=='good_price'){
                    	   if(!reg[6].test($(this).val())||$(this).val()<=0){
                    		   nn = true ;
                    		   i = 3 ;
                    	   }
                       }
                       
                     
                    	var $inp = $('input:text');
               		      e.preventDefault();
                          var nxtIdx = $inp.index(this) + 1;
                          
                         
                          if($(":input:text:eq(" + nxtIdx + ")").prop('disabled')){
                           	 nxtIdx = $inp.index(this) + 2;
                            }
                            if($(":input:text:eq(" + nxtIdx + ")").prop('disabled')){
                            	 nxtIdx = $inp.index(this) + 3;
                             }
                            
                            if($(":input:text:eq(" + nxtIdx + ")").prop('disabled')){
                            	 nxtIdx = $inp.index(this) + 4;
                             }
                            
                            
                          if(nn){
                        	  nxtIdx = $inp.index(this) + i;
                          } 
                          
                          $(":input:text:eq(" + nxtIdx + ")").focus(); 
                       }
              	   }
                 }  
            });
    //
        	
		jQuery.ajax({
        		      url: '/codfile/tmjs/${lgcConfig.key}/${lgcConfig.curName}_${cmenu_sub_limit}.js',
        		      dataType: "script",
        		      cache: true
        		}).done(function() {
        			
          var data1 =tmjs.clist ;
        	var availablesrcKey1 = [];
            $.each(data1, function(i, item) {
            	var inner_no = "" ;
            	if(item.inner_no){inner_no=item.inner_no+','}
            	availablesrcKey1[i]=item.courier_no.replace(/\ /g,"")+'('+inner_no+item.real_name.replace(/\ /g,"")+')';
            });
            val1 = '';
              $jqq("#take_courier_no").autocomplete(availablesrcKey1, {
           		minChars: 0,
           		max: 12,
           		autoFill: true,
           		mustMatch: false,
           		matchContains: true,
           		scrollHeight: 220,
           		formatItem: function(data11, i, total) {
           			return data11[0];
           		}
           	}).result(function(event, data, formatted) {
           		if(data[0].indexOf(')')>-1){
         			 $("#take_courier_no").val(data[0].substring(0,data[0].indexOf('('))) ;
         			 $("#take_courier_name").val(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
   			       } 
           		$("#send_courier_name").focus();
         	});	
        
            $jqq("#send_courier_no").autocomplete(availablesrcKey1, {
           		minChars: 0,
           		max: 12,
           		autoFill: true,
           		mustMatch: false,
           		matchContains: true,
           		scrollHeight: 220,
           		formatItem: function(data11, i, total) {
           			return data11[0];
           		}
           	}).result(function(event, data, formatted) {
           		if(data[0].indexOf(')')>-1){
         			 $("#send_courier_no").val(data[0].substring(0,data[0].indexOf('('))) ;
         			 $("#send_courier_name").val(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
   			       } 
           		$("#sendName").focus();
         	});				 


             	var mlist = tmjs.mlist ; 
             	var mres = [];
             	$.each(mlist, function(i, item) {
             		var name = item.month_sname ;
             		if(name.length<1){name = item.month_name ;}
                  	mres[i]=item.month_settle_no.replace(/\ /g,"")+'('+name.replace(/\ /g,"")+')';
                  }); 
             	  $jqq("#monthSettleNo").autocomplete(mres, {
               		minChars: 0,
               		max: 12,
               		autoFill: true,
               		mustMatch: false,
               		matchContains: true,
               		scrollHeight: 220,
               		formatItem: function(data, i, total) {
               			return data[0];
               		}
               	}).result(function(event, data, formatted) {
               		if(data[0].indexOf(')')>-1){
               			 $("#monthSettleNo").val(data[0].substring(0,data[0].indexOf('('))) ;
               			 $("#monthSname").val(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
         			       } 
               		//_submit() ;
               	}); 
               			 
            	var codList = tmjs.codlist ;	 
             	var codres = [];
             	$.each(codList, function(i, item) {
             		var name = item.cod_sname ;
             		if(name.length<1){name = item.cod_name ;}
             		codres[i]=item.cod_no.replace(/\ /g,"")+'('+name.replace(/\ /g,"")+')';
                  }); 
             	  $jqq("#cod_no").autocomplete(codres, {
               		minChars: 0,
               		max: 12,
               		autoFill: true,
               		mustMatch: false,
               		matchContains: true,
               		scrollHeight: 220,
               		formatItem: function(data, i, total) {
               			return data[0];
               		}
               	}).result(function(event, data, formatted) {
               		if(data[0].indexOf(')')>-1){
               			 $("#cod_no").val(data[0].substring(0,data[0].indexOf('('))) ;
               			 $("#cod_sname").val(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
         			       } 
               		$('input[name=freight]').focus();
               	}); 				 
             	 
              }); // 联想缓存    

     	  
     	   $('#submit').click(function(){
     		  _submit() ;
     	   });
     	   
            
        });
        
   function _submit(){
		  if($("#vf").validationEngine("validate")){  
    		   
    		 var lgcOrderNo = $('input[name=lgcOrderNo]').val();
    		  if(lgcOrderNo.length<2){
    			 alert('请输入快递公司运单号');
    			 return false;
    		   }
    		 var tdate =  $('input[name=tdate]').val() ;
    		 var sdate =  $('input[name=sdate]').val() ;
    		 var sendKehu = $('input[name=send_kehu]').val() ;
    		 var sendName = $('input[name=sendName]').val() ;
   		     var sendAddr = $('input[name=sendAddr]').val() ;
   		     var sendPhone = $('input[name=sendPhone]').val() ;
   		  var idCard = $('input[name=idCard]').val() ;
		     
  		   var sprovince = 	$('select[name=sprovince]').val() ;
		   var scity = 	$('select[name=scity]').val() ;
		   var sarea = 	$('select[name=sarea]').val() ;
   		   
   		     var revKehu = $('input[name=rev_kehu]').val() ;
              var revName = $('input[name=revName]').val() ;
    		  var revAddr = $('input[name=revAddr]').val() ;
    		  var revPhone = $('input[name=revPhone]').val() ;
    		  
    		  var rprovince = 	$('select[name=rprovince]').val() ;
			   var rcity = 	$('select[name=rcity]').val() ;
			   var rarea = 	$('select[name=rarea]').val() ;
			   
			  var sendArea = sprovince +'-'+ scity +'-'+ sarea ;   
 			 var revArea = rprovince  +'-'+ rcity +'-'+ rarea ;  
 			 
    			 var itemStatus =  $('#itemStatus').val() ;  
    			 var agingType =  $('#agingType').val() ;  
    			 var reqRece = $('input[name=reqRece]').val() ;
    			 var receNo = $('input[name=receNo]').val() ;
    			 var orderNote = $('input[name=orderNote]').val() ; 
    			 
    		var take_courier_no = $('input[name=take_courier_no]').val();
    		var send_courier_no = $('input[name=send_courier_no]').val();
            	var item_count = $('input[name=item_count]').val() ;
    			var item_weight = $('input[name=item_weight]').val() ;
    			var good_price = $('input[name=good_price]').val() ;
    			var return_type = '1' ;
    			var forNo = $('input[name=forNo]').val() ;
    			var zidanOrder = $('input[name=zidanOrder]').val() ;
    			
    			if('现金'==return_type){return_type = 1 ;}
    			if('转账'==return_type){return_type = 2 ;}
    			
    			var cod_name = $('input[name=cod_name]').val() ;
    			var freight = $('input[name=freight]').val() ;
    			
    			if(freight<=0){
    				alert("邮费必须大于0") ;
    				$('input[name=freight]').focus();
    				 return false;
    			}
    			
    			var cod = 0 ;
    			if(good_price>0){
    				cod = 1 ;
    			}
    			
    			var payAcount = $('input[name=payAcount]').val() ;
    			
    			//var cpay = $('input[name=cpay]').val() ;
    			var cpay = 0 ;
    			var vpay = $('input[name=vpay]').val() ;
    			var goodValuation = $('input[name=goodValuation]').val() ;
    			//var goodValuation =  0 ;
    			
    			 if(freight.length<1){
     		    	$('input[name=freight]').focus();
     				 return false;
     			 }


    			var freight_type = $('input[name=freight_type]').val() ;
    			 if(freight_type.length<1){
      				 return false;
      			 }
    			if('寄方付'==freight_type){freight_type = 1 ;}
    			if('到方付'==freight_type){freight_type = 2 ;}
    			
    			var monthSettleNo = $('input[name=monthSettleNo]').val() ;
    			var payType = $('input[name=payType]').val() ;
    			if('现金'==payType||'1'==payType){payType = 'CASH' ;}
    			if('月结'==payType||'2'==payType){payType = 'MONTH';}
    			if('会员卡'==payType||'3'==payType){payType = 'HUIYUAN' ;}
    			
    			var itemName  = $('input[name=itemName]').val() ;
    			
    			 $.ajax({
    				 type: "post",//使用get方法访问后台
    		            dataType: "text",//返回json格式的数据   
    		           url: "/order_ext/order_edit_save",//要访问的后台地址
    		            data: {
    		            	'lgcOrderNo':lgcOrderNo,'sendName':sendName,'sendPhone':sendPhone,'sendArea':sendArea,'sendAddr':sendAddr,'sendKehu':sendKehu,
    		            	   'revName':revName,'revPhone':revPhone,'revArea':revArea,'revAddr':revAddr,'itemName':itemName,'cod':cod,'revKehu':revKehu,
    		            	   'receNo':receNo,'orderNote':orderNote,'takeCourierNo':take_courier_no,'sendCourierNo':send_courier_no,'itemCount':item_count,
    		            	  'itemWeight_':item_weight,'goodPrice_':good_price,'codName':cod_name,'vpay_':vpay,'vweight':'0','zidanOrder':zidanOrder,
    		            	 'goodValuation_':goodValuation,'freight_':freight,'payAcount_':payAcount,'freightType':freight_type,'monthSettleNo':monthSettleNo,'returnType':return_type,
    		            	'payType':payType,'reqRece':reqRece,'forNo':forNo,'tdate':tdate,'sdate':sdate,'itemStatus':itemStatus,'timeType':agingType,'idCard':idCard
    		            },//要发送的数据
    		           beforeSend:loading,
    		            success: function(msg){//msg为返回的数据，在这里做数据绑定
    		            	if('1'==msg){
    		            		loaded() ;
    		            		alert("修改成功");
    		            	}else{
    		            		loaded() ;
    		            		alert(msg);
    		            	}
    		            }
    			 }); 
    		  }   
		
   }

    </script>
</head>
<body>
<table class="loading" style="display: none;">
<tr>
<td><img src="${ctx }/themes/default/images/loading.gif" alt="" /></td>
</tr>
</table>
<div style="height: 10px;"></div>
<div style="min-width: 1200px;">
  <div class="xy_check_cont">
<div class="jiedit">
    <div class="check_code">
   <div class="check_code_name">运单号</div>
      <form:form id="trans" action="${ctx}/order_ext/oedit" method="get" >
      <input type="text" placeholder="请输入" value="${lgcOrderNo}" class="validate[required,funcCall[lgcOrderNo]]" name="lgcOrderNo" id="lgcOrderNo" />
         <div class="soso_button" style="margin: 0;">
        <input type="button" onclick="this.form.submit()" value="查询" style="width: 120px;height: 30px;line-height: 20px;background: rgb(28,122,216); border: 1px solid #1c7ad8;color: #fff;" />
      </div>
      </form:form> 
   </div>
    <form:form id="vf" action="${ctx}/order/input" method="get" onsubmit="return inputCheck1();" > 
    <input type="hidden" name="sign" value="${parmas.sign}"/>
    <div class="check_cont">
      <div class="check_cont_left">
       
     
      <div class="check_li">
          <div class="soso_b">寄件网点</div>
          <div class="soso_input">
            <input class="validate[required1]" type="text" disabled="disabled" id="tsubstationNo" name="substationNo" value="${orderMap.sub_station_no}"  />
            <input class=" " type="text" name="target_addr"  id="tsubstation_name" disabled="disabled"  value='<u:dict name="S" key="${orderMap.sub_station_no}" />' />
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b">派件网点</div>
          <div class="soso_input">
            <input class="validate[required1]" disabled="disabled"  type="text" id="send_substation_no" value="${orderMap.send_substation_no}" name="send_substation_no" />
            <input class=" " type="text" name="target_addr"  id="send_substation_name" disabled="disabled"  value='<u:dict name="S" key="${orderMap.send_substation_no}" />'  />
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b">&nbsp;&nbsp;取件员&nbsp;</div>
          <div class="soso_input">
                  <input  id="take_courier_no"  value="${orderMap.take_courier_no}" name="take_courier_no"   type="text"  maxlength="50"/>
                  <input type="text" name="take_courier_name" id="take_courier_name"  disabled="disabled"  value='<u:dict name="C" key="${orderMap.take_courier_no}" />' />
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b">&nbsp;&nbsp;派件员&nbsp;</div>
          <div class="soso_input">
                  <input id="send_courier_no" <c:out value="${orderMap.status ne '3' ?'disabled':'' }"/>  name="send_courier_no" value="${orderMap.send_courier_no}"  type="text"  maxlength="50"/>
                  <input class=" " type="text" name="send_courier_name" id="send_courier_name" disabled="disabled"  value='<u:dict name="C" key="${orderMap.send_courier_no}" />' />
          </div>
        </div>
        
        
         <div class="check_li aa">
          <div class="soso_b">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重量&nbsp;</div>
          <div class="soso_input">
            <input  type="text"  placeholder="必填" class="validate[required,funcCall[xiaoshu]]"  name="item_weight" id="itemWeight" value="${orderMap.item_weight}" />
          </div>
        </div>
      <%--   <div class="check_li">
          <div class="soso_b">结算重</div>
          <div class="soso_input">
            <input class="one validate[required,funcCall[xiaoshu]]"  placeholder="必填" value="${orderMap.item_weight}" name="item_weight" type="text"  maxlength="11">
          </div>
        </div> --%>
        
        <div class="check_li">
          <div class="soso_b">&nbsp;&nbsp;件数&nbsp;</div>
          <div class="soso_input">
            <input name="item_count" class="one validate[custom[integer]] text-input" id="item_count" type="text"   value="${orderMap.item_count}"/>
          </div>
        </div>
        
                <div class="check_li aa">
          <div class="soso_b">&nbsp;&nbsp;保价费&nbsp;</div>
          <div class="soso_input">
            <input name="goodValuation" id="goodValuation"  placeholder="" class="validate[funcCall[xiaoshu]]" <c:out value="${orderMap.status>1 ?'disabled':'' }"/>    value="${orderMap.good_valuation}" type="text"  maxlength="50">
          </div>
        </div>
        <div class="check_li">
          <div class="soso_b">手续费</div>
          <div class="soso_input">
            <input class="one cmount validate[funcCall[xiaoshu]]"  name="vpay" <c:out value="${orderMap.status>1?'disabled':'' }"/>  type="text" value="${orderMap.vpay}"  maxlength="20"   />
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b"></div>
          <div class="soso_input">
            <input class="one validate[funcCall[xiaoshu]]"  style="display: none;" disabled="disabled" value="${orderMap.item_weight}" name="vweight" type="text"  maxlength="11"/>
          </div>
        </div>
        <div class="check_li aa">
          <div class="soso_b">代收款</div>
          <div class="soso_input">
            <input name="good_price"  id="good_price" class=" cmount validate[funcCall[xiaoshu]]"   value="${orderMap.good_price}"  type="text"  maxlength="50"/>
          </div>
        </div>
        
       <%--  <div class="check_li">
          <div class="soso_b">返款方式</div>
          <div class="soso_input">
             <input type="text" name="return_type" id="" value="${orderMap.return_type}"  class="three validate[funcCall[fanhuan]]"/><span style="color:red;"/>1：现金，2：转账</span>
          </div>
        </div> --%>
        
        
        <div class="check_li">
          <div class="soso_b">&#12288;货款号</div>
          <div class="soso_input">
            <input  class="validate[funcCall[zys]]" id="cod_no" name="cod_name" value="${orderMap.cod_name}"   type="text"  maxlength="50"/>
            <input id="cod_sname" name="cod_sname" disabled="disabled"  type="text"  maxlength="50" value='<u:dict name="COD" key="${orderMap.cod_name}" />' />
          </div>
        </div><!--check_li end-->
        <div class="check_li aa">
          <div class="soso_b">快递运费</div>
          <div class="soso_input">
            <input name="freight" id="freight"  class="cmount validate[required,funcCall[xiaoshu]]"     value="${orderMap.freight}" type="text"  maxlength="50"/>
          </div>
        </div>
        <div class="check_li">
          <div class="soso_b">费用合计</div>
          <div class="soso_input">
             <input class=" two" type="text" name="v_amount"  value="${orderMap.freight+orderMap.vpay}"  disabled="disabled"/>
              <input value="${orderMap.tnpay}"  name="tnpay" type="hidden"  maxlength="60" />
               <input value="${orderMap.pay_amount}"  name="payAmount" type="hidden"  maxlength="60" />
          </div>
        </div><!--check_li end-->
        <div class="check_li aa" style="min-width: 240px;">
          <div class="soso_b">&nbsp;&nbsp;付款人&nbsp;</div>
          <div class="soso_input">
            <input type="text" class="three validate[required,funcCall[freight_type]]"  name="freight_type"   value="${orderMap.freight_type}" ><span style="color:red;"/>1：寄付，2：到付</span>
          </div>
        </div><!--check_li end-->
        <div class="check_li">
          <div class="soso_b">付款方式</div>
          <div class="soso_input">
            <input class="three cmount validate[funcCall[paytype]]" name="payType" type="text"    value="${orderMap.pay_type}" ><span style="color:red;"/>1：现金，2：月结</span>
          </div>
        </div>
        
        
        <div class="check_li">
          <div class="soso_b">月结账号</div>
          <div class="soso_input">
              <input  class="validate[funcCall[monthSettle]]" id="monthSettleNo" name="monthSettleNo"   value="${orderMap.month_settle_no}"  type="text"  maxlength="50"/>
              <input class=" " type="text" name="monthSname" id="monthSname"  disabled="disabled"  value='<u:dict name="MONTHUSER" key="${orderMap.month_settle_no}" />' />
          </div>
        </div><!--check_li end-->
        
             <div class="check_li">
          <div class="soso_b">备　　注</div>
          <div class="soso_input">
            <input class="two " type="text" id="orderNote" name="orderNote" placeholder="新增备注记录" >
          </div>
        </div>  
        
        
      </div><!--check_cont_left end-->
      <div class="check_cont_left check_cont_right02">
        
          <div class="check_li">
          <div class="soso_b">寄件时间</div>
          <div class="soso_input">
             <input id="tdate" class="two" onFocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd  HH:mm',readOnly:true,maxDate:'#F{\'%y-%M-%d %H:%m\'}'})" <c:out value="${orderMap.examine_status eq 'PASS' ?'disabled':'' }"/>  type="text"  name="tdate" value="${params['tdate']}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b">签收时间</div>
          <div class="soso_input">
             <input id="sdate" class="two" <c:out value="${orderMap.status ne '3' ?'disabled':'' }"/> onFocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd  HH:mm',readOnly:true,maxDate:'#F{\'%y-%M-%d %H:%m\'}'})" <c:out value="${orderMap.sign_examine_status eq 'PASS' ?'disabled':'' }"/>  type="text"  name="sdate" value="${params['sdate']}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
          </div>
        </div>

         <div class="check_li">
          <div class="soso_b">联系电话</div>
          <div class="soso_input">
            <input class=" pf validate[funcCall[zys]]" name="sendPhone" id="sendPhone"  value="${orderMap.send_phone}"  type="text"  maxlength="15" style="width: 140px;"/>
          </div>
        </div>  
        
        
         <div class="check_li ">
          <div class="soso_b">&nbsp;&nbsp;寄件人&nbsp;</div>
          <div class="soso_input">
             <input id="sendName" name="sendName" class="one validate[funcCall[zys]]" value="${orderMap.send_name}"  type="text"   maxlength="20" style="width: 130px;" />
          </div>
        </div> 
        
         <div class="check_li">
          <div class="soso_b">身份证号</div>
          <div class="soso_input">
             <input id="idCard" name="idCard" class="two validate[funcCall[zys]]" value="${orderMap.id_card}"   type="text"   maxlength="25"    />
          </div>
        </div> 
        
        
        <div class="check_li">
          <div class="soso_b">寄件公司</div>
          <div class="soso_input">
             <input class=" two" type="text" name="send_kehu" id="send_kehu"  value="${orderMap.send_kehu}"   placeholder=" " />
          </div>
        </div>
        <div class="check_li">
          <div class="soso_b">&#12288;&#12288;地址</div>
          
           <div class="soso_input">
           <select  name="sprovince"  class="select_a"  id="sprovince" onchange="javascript:ChangeProvincel('stips','scity',this.options[this.selectedIndex].value)">
          </select>
          <select  name="scity"  class=" select_a"  id="scity" onchange="javascript:ChangeCityl('stips','sarea',this.options[this.selectedIndex].value)">
          </select>
          <select name="sarea"  class=" select_a"  id="sarea" onchange="javascript:ChangeAreal('stips')">
          </select>
          </div>
          
        </div>
        
           <div class="check_li">
          <div class="soso_b">&#12288;&#12288;&#12288;&#12288;</div>
          <div class="soso_input">
            <input class="two" type="text" name="sendAddr" id="sendAddr"  value="${orderMap.send_addr}"   >
          </div>
        </div>
        
             
        <div class="check_li">
          <div class="soso_b">联系电话</div>
          <div class="soso_input">
            <input class="pf validate[funcCall[zys]]" name="revPhone"  id="revPhone"  value="${orderMap.rev_phone}"  type="text" maxlength="15" style="width: 140px;">
          </div>
        </div> 
        
           <div class="check_li">
          <div class="soso_b">&nbsp;&nbsp;收件人&nbsp;</div>
          <div class="soso_input">
             <input  name="revName" class="one validate[funcCall[zys]]" type="text" id="revName"  value="${orderMap.rev_name}"   maxlength="20" style="width: 130px;">
          </div>
        </div>
        
          <div class="check_li">
          <div class="soso_b">&#12288;&#12288;地址</div>
          
           <div class="soso_input">
           <select class="select_a" name="rprovince"   id="rprovince" onchange="javascript:ChangeProvincel('rtips','rcity',this.options[this.selectedIndex].value)">
          		</select>
          		<select class="select_a" name="rcity" id="rcity" onchange="javascript:ChangeCityl('rtips','rarea',this.options[this.selectedIndex].value)">
          		</select>
          		<select class="select_a" name="rarea"   id="rarea" onchange="javascript:ChangeAreal('rtips')">
          		</select>
          </div>
          
        </div>
         
       <div class="check_li">
          <div class="soso_b">&#12288;&#12288;&#12288;&#12288;</div>
          <div class="soso_input">
            <input name="revAddr" class="two validate[funcCall[zys]]"  id="revAddr" type="text"  value="${orderMap.rev_addr}"    maxlength="60" />
          </div>
        </div>
        
      </div><!--check_cont_left end-->
      <div class="check_cont_left check_cont_right02">
        
           <div class="check_li" style="width: 215px">
          <div class="soso_b">物品类型</div>
          <div class="soso_input">
            <u:select id="itemStatus" sname="itemStatus" stype="ITEM_TYPE"  value="${orderMap.item_Status}"/>
          </div>
        </div>
        
         <div class="check_li">
          <div class="soso_b">物品名称</div>
          <div class="soso_input">
           <input id="itemName"  type="text" name="itemName" value="${orderMap.item_name}" style="width: 130px;"/>
          </div>
        </div>
        
            <div class="check_li " style="width: 215px">
          <div class="soso_b">时效类型</div>
          <div class="soso_input">
            <u:select id="agingType" sname="agingType" stype="AGING_TYPE"  value="${orderMap.time_type}"/>
          </div>
        </div>
        
        <div class="check_li aa" style="min-width: 293px;">
          <div class="soso_b">是否回单</div>
          <div class="soso_input">
            <input  class="three validate[funcCall[yesno]]" type="text" name="reqRece" value="${orderMap.req_rece}"/><span style="color:red;">0：否，1：是</span>
          </div>
        </div>
         <div class="check_li">
          <div class="soso_b">&#12288;回单号</div>
          <div class="soso_input">
            <input class="two "  type="text" name="receNo" value="${orderMap.rece_no}" placeholder=" "/>
          </div>
        </div>
          <div class="check_li">
          <div class="soso_b">&#12288;子单号</div>
          <div class="soso_input">
            <input class="two "  type="text" name="zidanOrder"  placeholder="多个请以逗号分隔" value="${orderMap.zidan_order}"/>
          </div>
        </div>
        
        <div class="check_li">
          <div class="soso_b">&#12288;转单号</div>
          <div class="soso_input">
             <input class="two  " type="text"  name="forNo" id="forNo" value="${orderMap.for_no}" placeholder=" "/>
          </div>
        </div>
       

     
      </div><!--check_cont_left end-->
    </div><!--check_cont end-->
    <div class="check_button">
    	<input id="submit" name="submit" type="button" value="提交"  />
    </div>

    </div><!--jiedit end-->
    <div></div>
    
  </div><!--xy_check_cont end-->
   </form:form>
</div>
</body>


</html>