<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 맵 보여야 함, 리뷰(코멘트) 작성 가능해야 함 -->
<!-- 코멘트에 별점 -->
<div>샵사진~~</div>
<c:forEach items="${shopPicList}" var="item">
	<div>${item.shop_pic }</div>
</c:forEach>
<hr>
<div>가게이름</div>
<div>${shopDetail.shop}</div>