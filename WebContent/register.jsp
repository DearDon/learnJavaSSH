<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%@taglib uri="/struts-tags" prefix="s" %> 
  <s:head theme="ajax"/>
    <base href="<%=basePath%>">
    
    <title>My JSP 'register.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    
    <s:text name="register.info"></s:text><br>
    <s:form action="Register" validate="true" theme="ajax">
    	<s:textfield name="custname" key="custname.label"></s:textfield>
    	<s:password name="pwd" key="pwd.label"></s:password>
    	<s:textfield name="age" key="age.label"></s:textfield>
    	<s:textfield name="address" key="address.label"></s:textfield>
    	<s:submit key="register.button"></s:submit> 	
    </s:form>
  </body>
</html>
