package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

public class DBCon {
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
	public static Map<String,Object> getOne(String sql,Object...param){
		QueryRunner qr = new QueryRunner();
		try(Connection con = getCon()){
			return qr.query(con,sql,new MapHandler(),param);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static List<Map<String,Object>> getList(String sql,Object...params){
		QueryRunner qr = new QueryRunner();
		try(Connection con = getCon()){
			return qr.query(con,sql,new MapListHandler(),params);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static int save(String sql, Object...params) {
		QueryRunner qr = new QueryRunner();
		try(Connection con = getCon()){
			return qr.update(con,sql,params);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	public static void main(String[] args) {
		Connection con;
		try {
			con = getCon();
			System.out.println(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String sql= "select * from member_tbl_02";
		List<Map<String,Object>> list = getList(sql);
		System.out.println(list);
		
		sql = "select * from member_tbl_02 where custno=?";
		Map<String,Object> map = getOne(sql,"100001");
		System.out.println(map);
		
		sql = "insert into member_tbl_02(custno, custname,\r\n" + 
				"phone, address, joindate, grade, city)\r\n" + 
				"VALUES(seq_member_tbl_02_custno.nextval, ?,?,?,?,?,?)\r\n";
		Object[] param = new Object[] {"조용히해","010-5674-5211","서울","2020-05-10","A","01"};
		System.out.println(save(sql,param));
		
	}
}
