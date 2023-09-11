<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String uId = request.getParameter("userID");
	String upw = request.getParameter("userPassword");
	
	String dbType = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/odbo";
    String username = "root";
    String password = "123456";
    Connection conn = null;
    
    ResultSet rs = null;
    
    
    try {
    	Class.forName(dbType);
    	conn = DriverManager.getConnection(url, username, password);
    	String sql = "SELECT *FROM members WHERE id = ?";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	
    	pstmt.setString(1, uId);
    	
    	rs=pstmt.executeQuery();
    	
    	if (rs.next()) {
    		String dbId = rs.getString(1);
    		String dbPw = rs.getString(2);
    		String dbMail = rs.getString(3);
    		if (upw.equals(dbPw)) {
    		    // 세션에 사용자 ID를 저장하고 다른 페이지로 리디렉션
    		    session.setAttribute("s_id", uId);
    		    response.sendRedirect("loginSuccess.jsp");
    		} else {
    		    // 비밀번호가 일치하지 않을 경우 다른 페이지로 리디렉션
    		    response.sendRedirect("loginFaild.jsp");
    		}
    	}else{
    		%>
    			<script>
    				alert("회원정보가 존재하지않습니다.");
    				window.location.replace("login.jsp");
    			</script>
    		
    		<% 
    	}
    }catch(Exception e){
    	e.printStackTrace();
    }

%>
</head>
<body>

</body>
</html>