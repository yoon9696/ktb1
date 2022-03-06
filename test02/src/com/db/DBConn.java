package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

public class DBConn {
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	public static Connection getCon() throws SQLException {
		return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe","jtest","ezen1234");
	}
	public static List<Map<String,Object>> getList(String sql, Object...params){
		QueryRunner qr = new QueryRunner();
		try(Connection con =getCon()) {
			return qr.query(con, sql, new MapListHandler(),params);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static Map<String, Object> getOne(String sql,Object... param){
		QueryRunner qr = new QueryRunner();
		try(Connection con =getCon()) {
			return qr.query(con, sql, new MapHandler(), param);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static int save(String sql, Object...params) {
		QueryRunner qr = new QueryRunner();
		try(Connection con =getCon()) {
			return qr.update(con, sql, params);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	public static void main(String[] args) {
		String sql = "select * from member_tbl_02";
		List<Map<String,Object>> list = getList(sql);
		System.out.println(list);
		
		sql = "select * from member_tbl_02 where custno=?";
		Map<String,Object> map = getOne(sql,100001);
		System.out.println(map);
		
		sql ="insert into member_tbl_02(custno,custname,\r\n" + 
				" phone, address, joindate, grade, city)\r\n" + 
				"VALUES(seq_member_tbl_02_custno.nextval, ?,?,?,?,?,?)";
		Object[] param = new Object[] {"따따따","010-5656-5656","서울","20210421","A","01"};
		System.out.println(save(sql,param));
		
		sql = "select mot.custno, custname,DECODE(grade,'A','vip','B','일반','C','직원') grade, sum(price) price\r\n" + 
				"from MEMBER_tbl_02 met , money_tbl_02 mot\r\n" + 
				"where met.custno = mot.custno\r\n" + 
				"group by mot.custno, custname, grade\r\n" + 
				"order by mot.custno";
		
		sql = "select mot.custno, custname,decode(grade,'A','VIP','B','일반','C','직원') grade, sum(price) price\r\n" + 
				"from MEMBER_TBL_02 met, MONEY_TBL_02 mot\r\n" + 
				"where met.custno = mot.custno\r\n" + 
				"group by mot.custno, custname, GRADE\r\n" + 
				"order by mot.custno";
		sql = "update MEMBER_TBL_02\r\n" + 
				"set custname=?,\r\n" + 
				"phone=?,\r\n" + 
				"joindate=?,\r\n" + 
				"grade=?,\r\n" + 
				"city=?\r\n" + 
				"where custno=?";
	//	System.out.println(getList("select * from member_tbl_02 where custname like ?", "%김%"));
	//	Object[] obj = new Object[] {100001,"김행복"};
		//System.out.println(getOne("select * from member_tbl_02 where custno=? and custname=?" , 100001, "김행복"));
	}
	

}
