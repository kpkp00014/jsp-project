<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<%
String user = (String) session.getAttribute("username");
String num = request.getParameter("bid");
System.out.println(user+ " "+ num);
Connection conn = null;
PreparedStatement pstmt = null;
Context initContext = new InitialContext();
Context envContext = (Context)initContext.lookup("java:/comp/env");
DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
conn = ds.getConnection();

String sql = "delete from board where bid=? and uid=?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1,num);
pstmt.setString(2,user);
pstmt.executeUpdate();
pstmt.close();
conn.close();
response.sendRedirect("board.jsp");
%>