<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" errorPage="error.jsp"%>
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
        <th class="tableTitle" colspan="2"><%=room.getR_name()%></th>
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

<div class="cards noselect">
    <c:forEach var="card" items="${cards}" varStatus="status">
        <div class="card noselect" data-index="${status.index}">${card}</div>
    </c:forEach>
</div>

<form action='exitRoom.jsp'>
<input type='submit' value='나가기'>
</form>
<script src="js/cardSelect.js"></script>