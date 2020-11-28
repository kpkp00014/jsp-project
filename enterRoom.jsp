<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%
   //방번호 get
   Integer roomnumber = Integer.parseInt(request.getParameter("rm"));
   session.setAttribute("room", roomnumber);
   response.sendRedirect("room.jsp");
%>
