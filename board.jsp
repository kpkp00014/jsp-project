<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>



<HTML>
<HEAD>
<TITLE>CardStack60</TITLE>
<link href="style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<script>
function toggle(e) {
    e.parentNode.parentNode.classList.toggle("closed");
}
function del_item(e) {
    const target = e.parentNode.parentNode;
    window.location.href = "/cardstack/board_delete.jsp?bid="+target.dataset.id;
}

</script>
<div align="center">
<jsp:include page="include/header.jsp">
    <jsp:param name="currentPage" value="board"/>
</jsp:include>
<div class="container">
    <form name="boardSubmitForm" method="post" action="board_submit.jsp">
        <input name="title" id="text_title" type="text" maxlength="40" class="input_title" placeholder="제목">
        <textarea name="body" id="text_body" rows="5" class="input_body" placeholder="내용"></textarea>
        <button class="input_btn">등록</button>
    </form>
    <div id="board_container">
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    Context initContext = new InitialContext();
    Context envContext = (Context)initContext.lookup("java:/comp/env");
    DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
    conn = ds.getConnection();
    String sql = "select * from board order by bid desc";
    String username = (String) session.getAttribute("username");
    pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();
    while(rs.next()){
        %>
        <div class='board_text closed' data-id='<%=rs.getString("bid")%>'>
            <div class='board_header'><span onClick='toggle(this)''>[<%=rs.getString("uid")%>] <%=rs.getString("title")%></span>
            <%
                if(rs.getString("uid").equals(username)) {
            %>
                <span class='delete_btn' onClick='del_item(this)'>❌</span>
            <%
                }
            %>
            </div>
            <div class='board_body'><%=rs.getString("body")%></div>
            <div class='board_footer'><%=rs.getString("date")%></div>
        </div>
        <%
    }
    rs.close();
    pstmt.close();
    conn.close();
    %>
</div>
</div>
<%@ include file="/include/footer.jsp"%>
</div>
</body>
</html>