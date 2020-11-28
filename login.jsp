<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();

		// select 문장을 문자열 형태로 구성한다.		
		String sql = "select * from user where id=? and password=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,request.getParameter("id"));
		pstmt.setString(2,request.getParameter("passwd"));
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			session.setAttribute("username",request.getParameter("id"));
			
		// 사용한 자원의 반납.
		rs.close();
		pstmt.close();
		conn.close();
		response.sendRedirect("index.jsp");
		} else {
			
			// 사용한 자원의 반납.
			rs.close();
			pstmt.close();
			conn.close();

			session.setAttribute("username", null);
			out.println("<script>");
			out.println("alert('로그인 실패')");
			out.println("location='index.jsp'");
			out.println("</script>");
		}
	}
	catch(Exception e) {
		out.println(e);
	}
%>