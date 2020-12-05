<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.*" %>

<%
if(session.getAttribute("room")!=null) {
    response.sendRedirect("room.jsp");
}
%>
<div class="container">

<a class="nodeco" href="logout.jsp"><button class="btn_short btn_logout">로그아웃</button></a>
<%
Connection conn = null;
PreparedStatement pstmt = null;
String uid=null, total=null, win=null, lose=null, rating=null, ranks=null;
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
        uid=rs.getString("id");
        total=rs.getString("total");
        win=rs.getString("win");
        lose=rs.getString("lose");
        rating=rs.getString("rating");
        ranks=rs.getString("ranking");
    }
    rs.close();
    pstmt.close();
    conn.close();
}catch(Exception e) {
    System.out.println("error: " + e);
}
%>
<table >
<tr><th>유저명</th><td><%=uid%></td></tr>
<tr><th>전적</th><td><%=total%>전 <%=win%>승 <%=lose%>패</td></tr>
<tr><th>승점</th><td><%=rating%>점</td></tr>
<tr><th>순위</th><td><%=ranks%>위</td></tr>
<table>


<form method=POST action=createRoom.jsp>
    <input class="btn_short createRoom" placeholder="방 이름을 입력해 주세요" name=r_name type="text"/>
    <input class="btn_short createRoom" type=submit value=방만들기>
</form>
<table >
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