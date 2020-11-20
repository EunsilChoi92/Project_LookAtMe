<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/res/css/shopList.css">
<!-- 전체 리스트, 검색 리스트 보여주는 곳 -->
<!-- 카테고리별로 선택할 수 있게 해야함 -->
<div id="msgSection">
	<div>
		예뻐지기 위한 놀이터, loOKatme
	</div>
</div>
<c:forEach items="${shopList}" var="item">
	<div class="cursor" onclick="location.href='/shop/detail?i_shop=${item.i_shop}'">
		<div>샵이름 : ${item.shop }</div>
		<div>샵 제일 앞 사진 : ${item.shop_pic }</div>
		<div></div>
	
		${item.shop }
	</div>
</c:forEach>
