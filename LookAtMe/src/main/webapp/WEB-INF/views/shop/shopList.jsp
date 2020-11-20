<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/res/css/shopList.css?ver=1">
<!-- 전체 리스트, 검색 리스트 보여주는 곳 -->
<!-- 카테고리별로 선택할 수 있게 해야함 -->
<div id="msgSection">
	<div>
		예뻐지기 위한 놀이터, loOKatme
	</div>
</div>
<div id="listContainer">
	<div>지역별 select</div>
	<div id="listFlex">
	<c:forEach items="${shopList}" var="item">
		<div class="shopContainer cursor" onclick="location.href='/shop/detail?i_shop=${item.i_shop}'">
			<img src="../../res/img/shop/${item.i_shop}/${item.shop_pic}">
			<div class="shopInfo">
				<div class="shopNm">${item.shop }</div>
				<div>${item.addr }</div>
				<div>${item.phone }</div>
			</div>		
		</div>
	</c:forEach>
	</div>
</div>
