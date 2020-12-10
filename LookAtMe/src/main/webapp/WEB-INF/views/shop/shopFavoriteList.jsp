<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css" href="/res/css/favShop.css">
<div id="sectionContainerCenter">
	<div id="favContainer">
	<div class="fontTitle" id="title"><span>LOOKING LIST</span></div>
	<c:if test="${fn:length(favoriteList) == 0}">
		<div id="noShopList">
			<div class="fontTitle" id="msg"><span>나만의 LOOKING LIST 를 만들어보세요</span></div>
		</div>
	</c:if>
	<c:forEach items="${favoriteList}" var="item">
		<div class="shopList">
			<div class="looking">
				<span class="fontTitle cursor" onclick="toggleFavoriteInList(this, ${item.i_shop})">
					DELETE
				</span>
			</div>
			<div class="shopNm">${item.shop }</div>
			<div class="shopAddr">${item.addr }</div>
			<div id="picContainer">
				<c:forEach items="${item.shopPicList }" var="pic">
					<div><img src="/res/img/shop/${item.i_shop}/${pic.shop_pic }"></div>
				</c:forEach>
			</div>
		</div>
	</c:forEach>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function toggleFavoriteInList(ele, i_shop) {
		if(confirm('삭제하시겠습니까?')) {
			const param = {
					params : {
						'i_shop' : i_shop,
						'proc_type' : (ele.innerText == 'DELETE' ? 'del' : 'ins')
					}
			}
			
			axios.get('/shop/ajaxLikeShop', param)
				.then(function(res) {
					console.log(res.data);
					if(res.data == 1) {
						ele.parentNode.parentNode.remove();
					}
				})
		}
	}
</script>