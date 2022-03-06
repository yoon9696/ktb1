<%@page import="java.util.Map"%>
<%@page import="java.math.BigDecimal"%>
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
table {
	width: 80%;
	margin: 80px;
}

h3 {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<%
	int custno =0;
	String joindate = null;
	String custname = request.getParameter("custname");
	if (custname != null) {
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		joindate = request.getParameter("joindate");
		String grade = request.getParameter("grade");
		String city = request.getParameter("city");

		Object[] params = new Object[]{custname, phone, address, joindate, grade, city};
		String sql = "insert into member_tbl_02(custno,custname,\r\n" + 
		" phone, address, joindate, grade, city)\r\n"+ 
		"VALUES(seq_member_tbl_02_custno.nextval, ?,?,?,?,?,?)";
		int result = DBConn.save(sql, params);
		if (result == 1) {
	%>
	<script>
		alert('회원등록이 완료되었습니다');
	</script>
	<%
		}
	}else{
			String sql ="select seq_member_tbl_02_custno.nextval as custno, to_char(SYSDATE,'YYYY-MM-DD') as joindate from dual";
			Map<String,Object> map = DBConn.getOne(sql);
			custno = ((BigDecimal)map.get("custno")).intValue();
			joindate = map.get("joindate").toString();
		}
	
	%>
	<section>
		<h3>홈쇼핑 회원등록</h3>
		<form onsubmit="return checkValue(this)">
			<table border="1">
				<tr>
					<th>회원번호(자동생성)</th>
					<td><input type="text" name="custno" value="<%=custno%>"></td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td><input type="text" name="custname"></td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td><input type="text" name="phone"></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input type="text" name="address"></td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td><input type="text" name="joindate" value="<%=joindate%>"></td>
				</tr>
				<tr>
					<th>고객등급</th>
					<td><input type="text" name="grade"></td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td><input type="text" name="city"></td>
				</tr>
				<tr>
					<th colspan="2">
						<button>등록</button>
						<button type="button" onclick="location.href='/member-list.jsp'">조회</button>
					</th>
				</tr>
			</table>
		</form>
	</section>
	<script>
		function checkValue(frm) {
			if (frm.custname.value == '') {
				alert('이름을 입력해주세요');
				frm.custname.focus();
				return false;
			}
			if (frm.phone.value == '') {
				alert('핸드폰 번호를 입력해주세요');
				frm.phone.focus();
				return false;
			}
			if (frm.address.value == '') {
				alert('주소를 입력해주세요');
				frm.address.focus();
				return false;
			}
			if (frm.joindate.value == '') {
				alert('가입일자를 입력해주세요');
				frm.joindate.focus();
				return false;
			}
			if (frm.grade.value == '') {
				alert('고객등급을 입력해주세요');
				frm.grade.focus();
				return false;
			}
			if (frm.city.value == '') {
				alert('도시코드를 입력해주세요');
				frm.city.focus();
				return false;
			}
		}
	</script>
	<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>