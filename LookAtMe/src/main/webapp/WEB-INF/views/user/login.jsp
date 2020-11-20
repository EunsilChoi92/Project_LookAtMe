<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/res/css/login.css">
<div id="sectionContainerCenter">
	<div id="loginContainer">
		<div id="loginBox">
			<div class="msg">${data.msg}</div>
			<form id="frm" class="frm" action="/user/login" method="post" onsubmit="return chkLength();">
				<div id="loginInput">
					<div><input type="text" name="user_id" placeholder="아이디를 입력하세요" value="${data.user_id}"></div>
					<div><input type="password" name="user_pw" placeholder="패스워드를 입력하세요"></div>
				</div>
				<div class="btnBox">
					<div><input class="loginBtn" type="submit" value="LOGIN"></div>
					<div><a href="/user/join"><button class="loginBtn">JOIN</button></a></div>
				</div>
			</form>
		</div>
	</div>
</div>