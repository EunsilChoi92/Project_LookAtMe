<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title }</title>
</head>
<body>
	<div onclick="location.href='/user/login'">로그인</div>
	<div onclick="location.href='/user/join'">횐가입</div>
	<hr>
	<div id="container">
		<jsp:include page="/WEB-INF/views/${view}.jsp"></jsp:include>	
	</div>
</body>
</html>