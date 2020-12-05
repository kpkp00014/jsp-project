<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>



<HTML>
<HEAD>
<TITLE>CardStack60</TITLE>
<link href="style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div align="center">
<jsp:include page="include/header.jsp">
    <jsp:param name="currentPage" value="ranking"/>
</jsp:include>
<div class="container">
<table border='1' class="ranking_table">
<tr><th>순위</th><th>ID</th><th>승점</th><th>승리</th><th>패배</th></tr>
<%
	// 데이터베이스 연결관련 변수 선언
	Connection conn = null;
    
    PreparedStatement pstmt = null;
	try{
        
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();
		
        // login된 상태라면?
        if(session.getAttribute("username")!=null){
            String sqlSelf = "call search_ranking(?)";
            String username = (String) session.getAttribute("username");
            pstmt = conn.prepareStatement(sqlSelf);
            pstmt.setString(1,username);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
            out.println("<tr class='highlight'><td>"
                +rs.getString("ranking")
                +"</td><td>"
                +rs.getString("id")
                +"</td><td>"
                +rs.getString("rating")
                +"</td><td>"
                +rs.getString("score_win")
                +"</td><td>"
                +rs.getString("score_lost")
                +"</td></tr>");
            }
            rs.close();
		    pstmt.close();
        }
        
       

		String sql = "call ranking";
		pstmt = conn.prepareStatement(sql);
    	ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            out.println("<tr><td>"
                +rs.getString("ranking")
                +"</td><td>"
                +rs.getString("id")
                +"</td><td>"
                +rs.getString("rating")
                +"</td><td>"
                +rs.getString("score_win")
                +"</td><td>"
                +rs.getString("score_lost")
                +"</td></tr>");
        }
        rs.close();
		pstmt.close();
		conn.close();

	}
	catch(Exception e) {
        System.out.println("error: " + e);
	}
%>
</table>
</div>
<%@ include file="/include/footer.jsp"%>

</div>
</body>
</html>