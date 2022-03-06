<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/style.css" />
<style>
table{
	width: 60%;
	margin:80px;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<section>
	<h3 style="text-align:center;">회원 매출조회</h3>  
	<table border="1">
	<tr>
		<th>회원번호</th>
		<th>회명성명</th>
		<th>고객등급</th>
		<th>매출</th>
	
		
	</tr>
	<%
	String sql = "select mot.custno, custname,decode(grade,'A','VIP','B','일반','C','직원') grade, sum(price) price\r\n" + 
			"from MEMBER_TBL_02 met, MONEY_TBL_02 mot\r\n" + 
			"where met.custno = mot.custno\r\n" + 
			"group by mot.custno, custname, GRADE\r\n" + 
			"order by mot.custno";
	List<Map<String,Object>> list = DBConn.getList(sql);
	for(Map<String,Object> map : list){
		

	%>
	<tr>
		<td><%=map.get("custno") %></td>
		<td><%=map.get("custname") %></td>
		<td><%=map.get("grade") %></td>
		<td><%=map.get("price") %></td>
	</tr>
	<%
	}
	%>
	</table> 
	</section>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>