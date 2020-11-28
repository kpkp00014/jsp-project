<%@ page language="java" contentType="text/html; charset=UTF-8"  import="java.sql.*" errorPage="error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<link href="style.css" rel="stylesheet" type="text/css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%@ page import="project.member.MemberBean" %>
<%= session.getAttribute("username") %> 님 환영 합니다.!!!!<BR>
<%
    
    Integer rNum = (Integer) session.getAttribute("room");
    RoomBean room = new RoomBean();
    // 현재 방 선택
    for(RoomBean r : rm.getRoomList()) {
        if(r.getR_id()==rNum) {
          room = r;
          break;
        }
    }

    String sessionId = (String) session.getId();
    String sessionUser = (String) session.getAttribute("username");
    
    // 방 멤버 목록에 추가되어있지 않다면,  추가한다
    if(!room.existR_member(sessionId)){
       room.add_member(sessionId, sessionUser);
    }
    ArrayList<MemberBean> r_member = room.getR_member();
    ArrayList<Integer> cards = room.getCard(sessionId);
    Integer gameNum = room.getGame_num();
    pageContext.setAttribute("r_member", r_member);
    pageContext.setAttribute("cards", cards);
%>
<%=session.getAttribute("room")%><br>
<%=room.existR_member(sessionId)%>
<h4>방 이름 : <%=room.getR_name()%></h4>



<div class="gameNum">
    <%=gameNum%>
</div>

<table>
    <tr>
    <%
        // 인게임 내에선 방제목이 아니라, 현재 누구의 턴인지를 표시한다
        if(room.get_currentStatus()==1) {
            if(room.get_currentUser()==session.getAttribute("username")) {
                // 플레이어의 턴인 경우
                %>
                <th class="tableTitle self" colspan="2">당신의 턴!</th>
                <%
            } else {
                // 다른 플레이어의 턴인 경우
                %>
                <th class="tableTitle" colspan="2"><%=room.get_currentUser()%>의 턴!</th>
                <%
            }
        } else {
            // status가 1이 아닌 경우
            %>
            <th class="tableTitle" colspan="2"><%=room.getR_name()%></th>
            <%
        }
    %>
        
    </tr>
    <tr>
        <th>이름</th>
        <th>보유 카드 수</th>
    </tr>
    <c:forEach var="member" items="${r_member}">
        <tr>
            <td>${member.getName()}</td>
            <td>${member.getCardNum()}</td>
        </tr>
    </c:forEach>
</table>
<%
    if(room.get_currentStatus()==1){
        // 게임 플레이 중일때만, 카드가 보인다
%>
<div class="cards noselect">
    <c:forEach var="card" items="${cards}" varStatus="status">
        <div class="card noselect" data-index="${status.index}">${card}</div>
    </c:forEach>
</div>
<%
    } else if (room.getR_memberSize()==3&&room.get_currentStatus()==0) {
        // game status가 1이고 플레이어가 3명이 모이면 게임을 시작한다
        room.game_start();
    }
%>
<form action='exitRoom.jsp'>
<input type='submit' value='나가기'>
</form>
<% if(room.get_currentUser()==session.getAttribute("username")) {
    // 자신의 차례일때만, 카드를 선택할 수 있다
    %>
<script src="js/cardSelect.js"></script>
<%
    }
%>

<%
    if(room.get_currentStatus()<2){
    // 게임이 종료 상태일 땐, 새로고침하지 않는다
%>
<script src="js/setTimeout.js"></script>
<%
    } else {
        String loser = room.get_loser();
        String winner = room.get_winner();

        if(room.get_loser() != null) {
            out.println("<script>alert('패배 : "+ loser + "')</script>");
        } else {
            out.println("<script>alert('승리 : "+ winner + "')</script>");
        }
        %>
    <div>
        <h4>게임이 종료되었습니다.</h4>
        <%
        if(loser!=null) out.println("<h4>"+loser+"님의 패배입니다.</h4>");
        else out.println("<h4>"+winner+"님의 승리입니다.</h4>");
        %>
    </div>
        <%
    }
%>