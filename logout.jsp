<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*"%>
<%
session.setAttribute("username", null);
response.sendRedirect("index.jsp");
%>