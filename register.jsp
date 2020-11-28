<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>

<%
	// 데이터베이스 연결관련 변수 선언
	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();

		// Connection 클래스의 인스턴스로 부터 SQL  문 작성을 위한 Statement 준비
		String sql = "insert into user values(?,?, 0, 0, 0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,request.getParameter("id"));
		pstmt.setString(2,request.getParameter("passwd"));
    	pstmt.executeUpdate();

		pstmt.close();
		conn.close();
        out.println("<script>");
        out.println("alert('회원가입 성공!')");
        out.println("location='index.jsp'");
        out.println("</script>");
	}
	catch(Exception e) {
        System.out.println(e);
        out.println("<script>");
        out.println("alert('회원가입 실패')");
        out.println("location='index.jsp'");
        out.println("</script>");
	}
%>
