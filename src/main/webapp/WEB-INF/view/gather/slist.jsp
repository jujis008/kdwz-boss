<%@ page contentType="text/html;charset=UTF-8"
         trimDirectiveWhitespaces="true" %>
<%@include file="/tag.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="/scripts/jquery-auto.js"></script> 
<script>
var $jqq = jQuery.noConflict(true);
</script> 
<script type="text/javascript" src="/scripts/jquery.autocomplete.js"></script>
    <script type="text/javascript">
    function commit(id){
    	 $.ajax({type: "post",url:'/gather/commit',data:{'ids':id,'examineStatus':'1'},success:function(msg){
			 if(msg==1){
				 alert('提交成功');
				 location.reload();
			 }else{
				 alert(msg);
			 }
		 }});
    }
    
    function edit(id){
    	$.dialog({lock: true,title:'编辑',drag: true,width:800,height:470,resize: false,max: false,content: 'url:${ctx}/gather/edit?id='+id+'&layout=no',close: function(){
    	
    	}});
    }

        $(function () {
            trHover('t2');
            $('#reload_btn').click(function(){
       		 location.reload() ;
       	});
            
            $('.select_all').click(function() {
           	 if($(this).prop("checked"))	{
           			$('input[name=ids]').each(function(){
                   		$(this).prop('checked',true); 
                   	}); 
           	 }else{
           		 $('input[name=ids]').each(function(){
                		$(this).prop('checked',false); 
                	}); 
           	 }
           
           });   
            
            $('#batch_commit').click(function(){
            	var ids = '';
            	$('.ids:checked').each(function(){
            		ids += $(this).val()+','; 
            	});
            	if(ids.length>0){
            		ids = ids.substring(0, ids.length-1) ;
            	}else{
            		alert("请选择一项或多项！");
            		return ;
            	}
            	 if(confirm("是否全部提交？")){
            		 $.ajax({type: "post",url:'/gather/commit',data:{'ids':ids,'examineStatus':'1'},success:function(msg){
               			 if(msg==1){
               				 alert('提交成功');
               				 location.reload();
               			 }else{
               				 alert(msg);
               			 }
               		 }});
               } 

          	});
            
      	  jQuery.ajax({
		      url: '/codfile/tmjs/${lgcConfig.key}/${lgcConfig.curName}_${cmenu_sub_limit}.js',
		      dataType: "script",
		      cache: true
		}).done(function() {	 
            var slist = tmjs.slist;
        	var clist = tmjs.clist;
        	var mlist = tmjs.mlist;
        	var sres = [];
        	var cres = [];
        	var mres = [];
        	$.each(slist, function(i, item) {
        		 var inner_no = "" ;
                	if(item.inner_no){inner_no=item.inner_no+',';}
        		sres[i]=item.substation_no.replace(/\ /g,"")+'('+inner_no+item.substation_name.replace(/\ /g,"")+')';
            });
           $.each(clist, function(i, item) {
        	   var inner_no = "" ;
              	if(item.inner_no){inner_no=item.inner_no+',';}
            	cres[i]=item.courier_no.replace(/\ /g,"")+'('+inner_no+item.real_name.replace(/\ /g,"")+')';
            }); 
           $.each(mlist, function(i, item) {
              	mres[i]=item.month_settle_no.replace(/\ /g,"")+'('+item.month_name.replace(/\ /g,"")+')';
              }); 
           
           $jqq("#courierNo").autocomplete(cres, {
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
        			 $("#courierNo").val(data[0].substring(0,data[0].indexOf('('))) ;
        			 $("#ctips").html(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
  			       } 
        	}); 
           
              $jqq("#substationNo").autocomplete(sres, {
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
        			 $("#substationNo").val(data[0].substring(0,data[0].indexOf('('))) ;
        			 $("#stips").html(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
    			       } 
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
             			 $("#mtips").html(data[0].substring(data[0].indexOf('(')+1,data[0].indexOf(')')));
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
    <form:form id="trans" action="${ctx}/gather/slist" method="get">
     <input type="hidden" name="serviceName" value=""/>
        <ul>
            <li>&#12288;网点编号：<input  name="substationNo" id="substationNo"  value="${params['substationNo']}" style="width: 200px;"  type="text"/>
            <div  style="color: white;background-color: gray;height:30px;display: inline-block;line-height: 30px;margin-left: 10px;padding: 0 10px;min-width: 100px;" id="stips">分站名称</div>
            </li>
              <li><span>账单日期：</span>
			 	<input onFocus="WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{\'%y-%M-%d\'}'})"   type="text"  style="width:112px" name="settleTime" value="${params['settleTime']}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			</li>
			  <li>月结类型：<select name="mtype" style="width: 110px">
			     <option value="" >全部</option>
                <option value="CASH" ${params['mtype'] eq 'CASH'?'selected':''}>现金</option>
                <option value="ZZ" ${params['mtype'] eq 'ZZ'?'selected':''}>转账</option>
                <option value="OT" ${params['mtype'] eq 'OT'?'selected':''}>其他</option>
             </select></li>
            	<div class="clear"/> 
             
             <li>快递员编号：<input  name="courierNo" id="courierNo"  value="${params['courierNo']}"  style="width: 200px;"  type="text"/>
              <div style="color: white;background-color: gray;height:30px;display: inline-block;line-height: 30px;margin-left: 10px;padding: 0 10px;min-width: 100px;" id="ctips">快递员&#12288;</div>
             </li>
             
         	 <li>月结账号：<input  name="monthSettleNo" id="monthSettleNo"  value="${params['monthSettleNo']}"  style="width: 200px;"  type="text"/>
              <div style="color: white;background-color: gray;height:30px;display: inline-block;line-height: 30px;margin-left: 10px;padding: 0 10px;min-width: 100px;" id="mtips">月结名称&#12288;</div>
             </li>
            <li><input class="button input_text  medium blue_flat"
                       type="submit" value="查询"/>
            </li>
            <li><input class="button input_text  medium blue_flat" 
                       type="reset" value="重置"/>
            </li>
        </ul>
    </form:form>
   </div>   <!-- search_cont end  -->
    <div class="clear"></div>
 </div>   <!-- tableble_search end  -->   
  <div class="tableble_search">
  	 <div class="operator">
	    <div class="search_new">   <input class="button input_text  big gray_flat" type="submit" value="刷新" id="reload_btn"/>  </div>
		  <shiro:hasPermission name="DEFAULT">
	     <div class="search_new">   <input style="width: 100px;" class="button input_text  medium blue_flat" type="submit" style="float: right;" value="全部提交" id="batch_commit"/>  </div>
	    </shiro:hasPermission>
	    </div>
  </div>   <!-- tableble_search end  -->    
</div>


<div class="tbdata">
    
    <table width="100%" cellspacing="0" class="t2" id="t2">
        <thead>
        <tr>
            
             <th align="center" >&#12288;<input class="select_all" name="select_all" type="checkbox"  />&#12288;</th>
            <th align="center" >网点编号</th>
            <th align="center" >网点名称</th>
            <th align="center" >快递员编号</th>
            <th  align="center" >快递员</th>
            <th align="center" >账单时间</th>
            <th  align="center" >收款时间</th>
             <th  align="center" >录入/收款员</th>
            <th  align="center" >邮费现金</th>
            <th  align="center" >代收款</th>
            <th  align="center" >会员现金</th>
            <th align="center" >月结账号</th>
            <th  align="center" >月结金额</th>
            <th  align="center" >月结类型</th>
            <th  align="center" >账单月份</th>
            <th  align="center" >合计</th>
            <th  align="center" >备注</th>
            <th  align="center" >操作</th>
        </tr>
        </thead>
        <tbody>
         <c:set var="sum_fcount" value="0"></c:set>
          <c:set var="sum_ccount" value="0"></c:set>
             <c:set var="sum_hcount" value="0"></c:set>
           <c:set var="sum_mcount" value="0"></c:set>
            <c:set var="sum_acount" value="0"></c:set>
        <c:forEach items="${list.list}" var="item" varStatus="status">
        <c:set var="sum_fcount" value="${sum_fcount+item.fcount}"></c:set>
        <c:set var="sum_ccount" value="${sum_ccount+item.ccount}"></c:set>
         <c:set var="sum_hcount" value="${sum_hcount+item.ccount}"></c:set>
        <c:set var="sum_mcount" value="${sum_mcount+item.mcount}"></c:set>
        <c:set var="sum_acount" value="${sum_acount+item.acount}"></c:set>
            <tr class="${status.count % 2 == 0 ? 'a1' : ''}">
                <td align="center"><input class="ids" name="ids" type="checkbox" value="${item.id}" /></td>
                <td>${fn:substring(item.substation_no,fn:length(item.substation_no)-3,fn:length(item.substation_no))}</td>
                  <td><u:dict name="S" key="${item.substation_no}" /></td>
                <td>${fn:substring(item.courier_no,fn:length(item.courier_no)-3,fn:length(item.courier_no))}</td>
                <td>${item.real_name}</td>
                <td>${item.settle_time}</td>
                <td><fmt:formatDate value="${item.create_time}" type="both"/></td>
                <td>${item.operator}</td>
                <td>${item.fcount}</td>
                <td>${item.ccount}</td>
                 <td>${item.hcount}</td>
                <td>${item.month_settle_no}</td>
                <td>${item.mcount }</td>
                <td><u:dict name="MTYPE" key="${item.mtype }"/></td>
                <td>${item.msettle_date}</td>
                <td>${item.acount}</td>
                <td>${item.note}</td>
                <td align="center">
					<shiro:hasPermission name="DEFAULT">
                   <a href="javascript:edit('${item.id}');">编辑</a>
                   </shiro:hasPermission>
					 <shiro:hasPermission name="DEFAULT">
                        |
                     <a href="javascript:commit('${item.id}');">提交</a>
                     </shiro:hasPermission>
                </td>
            </tr>
        </c:forEach>
             <tr style="background: #f5f5f5;border: none;" >
                <td align="center" colspan="8" style="background: #f5f5f5;border: none;"></td>
                <td style="background: #f5f5f5;border: none;"> 合计：${sum_fcount }</td>
                 <td style="background: #f5f5f5;border: none;"> 合计：${sum_ccount }</td>
                   <td style="background: #f5f5f5;border: none;"> 合计：${sum_hcount }</td>
                 <td style="background: #f5f5f5;border: none;"></td>
                  <td style="background: #f5f5f5;border: none;"> 合计：${sum_mcount }</td>
                   <td style="background: #f5f5f5;border: none;"  colspan="2"></td>
                   <td style="background: #f5f5f5;border: none;"> 合计：${sum_acount }</td>
                <td style="background: #f5f5f5;border: none;" colspan="2"></td>
            </tr>
        </tbody>
    </table>
</div>
<div id="page">
<pagebar:pagebar total="${list.pages}"  current="${list.pageNum}" sum="${list.total}"/>
</div>
</body>

</html>