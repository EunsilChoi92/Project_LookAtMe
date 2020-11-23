<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예뻐지기 위한 놀이터 LookAtMe${title }</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/res/css/star.css?ver=2">
<link rel="stylesheet" type="text/css" href="/res/css/common.css">
<style>
	html, body {
		margin: 0;
		padding: 0;
		height: 100%;
	}
	.cursor {
		cursor: pointer;
	}
	#container {
		height: 82vh;
	}
</style>
</head>
<body>
	<header>
		<div class="nav">
			<div class="logo cursor"  onclick="location.href='/'">
				loOKatme
			</div>
			<div class="navItems">
				<div>
					<div class="cursor" onclick="location.href='/'">MAIN</div>		
					<div class="cursor" onclick="location.href='/shop/regMod'">ADDSHOP</div>
				</div>
				<div class="navPages">
					<div class="cursor" onclick="location.href='/shop/favoriteList'">MYLIST</div>		
					<div class="cursor" onclick="location.href='/shop/favoriteList'">MYPAGE</div>		
				</div>
				<div class="navUser">
					<div class="cursor" onclick="chkLoginOrLogout()">
						${loginUser==null?"LOGIN":"LOGOUT"}
					</div>
					<div class="cursor" onclick="location.href='/user/join'">JOIN</div>
				</div>
			</div>
		</div>
	</header>
	<section>
		<div id="container">
			<jsp:include page="/WEB-INF/views/${view}.jsp"></jsp:include>	
		</div>
	</section>
	<footer>
	</footer>
	<script>
		function chkLoginOrLogout() {
			let status = 'login';
			
			if(${loginUser != null}) {
				if(confirm('로그아웃 하시겠습니까?')) {
					status = 'logout';
				} else {
					return;
				}
			}
			
			location.href=`/user/\${status}`;
		}
	</script>
</body>
</html>