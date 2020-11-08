<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title }</title>
<link rel="stylesheet" type="text/css" href="/res/css/star.css?ver=2">
<style>
	.cursor {
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="cursor" onclick="location.href='/'">메인</div>
	<div class="cursor" onclick="location.href='/user/${loginUser==null?'login':'logout'}'">
		${loginUser==null?"로그인":"로그아웃"}
	</div>
	<div class="cursor" onclick="location.href='/user/join'">횐가입</div>
	<div class="cursor" onclick="location.href='/shop/regMod'">샵등록</div>
	<hr>
	<div id="container">
		<jsp:include page="/WEB-INF/views/${view}.jsp"></jsp:include>	
	</div>
</body>
</html>