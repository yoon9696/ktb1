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
	width: 80%;
	margin:80px;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<section>
	<h3 style="text-align:center;">회원목록조회수정</h3>  
	<table border="1">
	<tr>
		<th>회원번호</th>
		<th>회명성명</th>
		<th>전화번호</th>
		<th>주소</th>
		<th>가입일자</th>
		<th>고객등급</th>
		<th>거주지역</th>
		
	</tr>
	<%
	String sql = "select custno,custname,phone,address, TO_CHAR(joindate,'YYYY-MM-DD') joindate, decode(grade,'A','VIP','B','일반','C','직원') grade,city from member_tbl_02";
	List<Map<String,Object>> list = DBConn.getList(sql);
	for(Map<String,Object> map : list){
		

	%>
	<tr>
		<td><a href="/member-update.jsp?custno=<%=map.get("custno") %>"><%=map.get("custno") %></a></td>
		<td><%=map.get("custname") %></td>
		<td><%=map.get("phone") %></td>
		<td><%=map.get("address") %></td>
		<td><%=map.get("joindate") %></td>
		<td><%=map.get("grade") %></td>
		<td><%=map.get("city") %></td>
	</tr>
	<%
	}
	%>
	</table> 
	</section>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>