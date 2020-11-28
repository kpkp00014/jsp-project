<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>CardStack60</TITLE>
<link href="style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div align="center">
<div class="header">
    <a href="/cardstack/ranking.jsp"><h3>랭킹</h3></a>
    <H2>메인 화면</H2>
    <a href="/cardstack/board.jsp"><h3>게시판</h3></a>
</div>
<HR>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.*" %>
<%
if(session.getAttribute("username")!=null){
    if(session.getAttribute("room")!=null) {
        response.sendRedirect("room.jsp");
    }
    %>
    <div class="main_info">
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
	try{
        
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
		conn = ds.getConnection();
        String sql = "call personal_info(?)";
        String user = (String) session.getAttribute("username");
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, user);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            out.println("<p>" + rs.getString("id")+ "님 환영합니다!</p>");
            out.println("<p>총 전적 : " + rs.getString("total") + "전 "+ rs.getString("win") +"승 " + rs.getString("lose") + "패</p>");
            out.println("<p>승점 : " + rs.getString("rating") +"점</p>");
            out.println("<p>순위 : " + rs.getString("ranking") + "위</p>");
        }
        rs.close();
        pstmt.close();
        conn.close();
    }catch(Exception e) {
        System.out.println("error: " + e);
	}
    %>
    </div>
    <form action="logout.jsp">
    <button>로그아웃</button>
    </form>
    
    <div>
    <form method=POST action=createRoom.jsp>
        <input name=r_name type="text"/>
        <input type=submit value=방만들기>
    </form>
    <table border='1'>
        <tr><th>방 번호</th><th>방 이름</th><th>인원수</th></tr>
        <%
        for(RoomBean room : rm.getRoomList()) {
        %>
            <tr>
            <td><%=room.getR_id() %></td>
            <td><a href="enterRoom.jsp?rm=<%=room.getR_id()%>"><%=room.getR_name() %></a></td>
            <td><%=room.getR_memberSize() %>/3</td>
            </tr>
        <%
        }
        %>
    </table>
    </div>
    <%
}
else {
    %>
    <a href="/cardstack/register_form.html">회원가입</a>
    <a href="/cardstack/login_form.html">로그인</a>
    <%
}
%>
</BODY>
</HTML>