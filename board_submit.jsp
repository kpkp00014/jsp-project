<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
    String title = request.getParameter("title");
    String body = request.getParameter("body");


    if(title.length()*body.length()>0) {
        try{
            Context initContext = new InitialContext();
            Context envContext = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
            conn = ds.getConnection();

            // select 문장을 문자열 형태로 구성한다.		
            String sql = "insert into board (uid, title, body) values (?,?,?);";
            pstmt = conn.prepareStatement(sql);
            String sessionUser = (String) session.getAttribute("username");
            pstmt.setString(1,sessionUser);
            pstmt.setString(2,request.getParameter("title"));
            pstmt.setString(3,request.getParameter("body"));
            // select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
            pstmt.executeUpdate();
            
            // 사용한 자원의 반납.
            pstmt.close();
            conn.close();
            response.sendRedirect("board.jsp");
        }
        catch(Exception e) {
            out.println(e);
        }
    } else {
        out.println("<script>alert('빈칸을 채워주세요!');history.go(-1);</script>");
    }
%>