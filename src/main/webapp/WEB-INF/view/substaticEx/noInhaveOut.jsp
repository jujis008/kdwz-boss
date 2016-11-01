<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="/WEB-INF/tlds/zh-html.tld" prefix="zh"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${constants['backend_title']}</title>
<jsp:include page="/WEB-INF/view/batch/head.jsp" />
<script type="text/javascript" src="/scripts/jquery-auto.js"></script>

<script>
var $jqq = jQuery.noConflict(true);
</script>
<script type="text/javascript" src="/scripts/jquery.autocomplete.js"></script>
<link  rel="stylesheet" href="<%=request.getContextPath()%>/themes/default/jquery.autocomplete.css"/>
	<script src="${pageContext.request.contextPath }/themes/script/jquery-1.6.3.js"></script>
<script>
$(function () {
    var courierList = ${courierList};
    var substationList = ${substationList};
	var cres = [];
	  var sres = [];
	  $.each(substationList, function(i, item) {
			sres[i]=item.substation_no.replace(/\ /g,"")+'('+item.inner_no.replace(/\ /g,"")+')'+'('+item.substation_name.replace(/\ /g,"")+')';
	   });
	  $.each(courierList, function(i, item) {
		  cres[i]=item.user_name.replace(/\ /g,"")+'('+item.real_name.replace(/\ /g,"")+')';
	   });

  $jqq("#outCourierNo").autocomplete(cres, {
		minChars: 0,
		max: 12,
		autoFill: true,
		mustMatch: false,
		matchContains: true,
		scrollHeight: 150,
		formatItem: function(data, i, total) {
			return data[0];
		}
	}).result(function(event, data, formatted) {
		if(data[0].indexOf(')')>-1){			
			 $("#outCourierNo").val(data[0].substring(0,data[0].indexOf('('))) ;
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
});

		</script>
</head>
<body>
	<div class="table" >
		<div class="ta_header">
			<form action="noInhaveOut?layout=no" method="post">
				<div class="ta_h_search"  style="overflow:hidden">
			
				
					出站扫描员 <input class="put_cont" type="text" name="outCourierNo" id = "outCourierNo"	
							placeholder="" value="${param.outCourierNo}">
					下一站 <input class="put_cont" type="text" name="substationNo" id = "substationNo"	
							placeholder="" value="${param.substationNo}">					
							<input		class="button_2" type="submit" value="查询">			
				</div>
					<input type="hidden" name="subNo" value="${params['subNo']}" />
					<input type="hidden" name="subName" value="${params['subName']}" />
					 <input type="hidden" name="scanTime" value="${params['scanTime']}"/>
			</form>
		</div>
		<div class="ta_table" style="max-height: none;">
			<table class="ta_ta" width="100%" cellpadding="0" cellspacing="0"
				border="0">
				<thead>
					<tr>
						<th width="10" align="center">序号</th>
						<th width="50" align="center">运单号</th>
						<th width="50" align="center">到站扫描时间</th>
						<th width="50" align="center">出站扫描时间</th>
						<th width="50" align="center">下一站</th>					
						<th width="50" align="center">下一站名称</th>
						<th width="50" align="center">出站扫描员</th>
						<th width="30" align="center">出站扫描员名称</th>
					</tr>
				</thead>
				<tbody>	
					<c:forEach items="${list.list}" var="item" varStatus="status">
						<tr class="${status.count % 2 == 0 ? 'a1' : ''}">
							<td align="center">${status.count}</td>
							<td>${item.lgcOrderNo}</td>
							<td>/</td>										
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.inTime}" /></td>
							<td></td>
							<td></td>	
							<td>${item.scanOno}</td>
							<td>${item.scanOname}</td>					 							
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>
		<div id="page">
			<pagebar:pagebar total="${list.pages}" current="${list.pageNum}"
				sum="${list.total}" />
		</div>
</body>
</html>
