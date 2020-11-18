<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach items="${favoriteList}" var="item">
	<div style="border:1px solid black">
		<h2>가게이름 : ${item.shop }</h2>		
		<h2>가게 사진 목록 이얍</h2>
		<c:forEach items="${item.shopPicList }" var="pic">
			<div>사진 : ${pic.shop_pic }</div>
		</c:forEach>
		<span class="material-icons cursor" onclick="toggleFavoriteInList(this, ${item.i_shop})">
			${item.is_favorite == 1 ? "favorite" : "favorite_border"}
		</span>
	</div>
</c:forEach>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function toggleFavoriteInList(ele, i_shop) {
		const param = {
				params : {
					'i_shop' : i_shop,
					'proc_type' : (ele.innerText == 'favorite' ? 'del' : 'ins')
				}
		}
		
		axios.get('/shop/ajaxLikeShop', param)
			.then(function(res) {
				console.log(res.data);
				if(res.data == 1) {
					ele.innerText = (ele.innerText == 'favorite' ? 'favorite_border' : 'favorite');
					ele.parentNode.remove();
				}
			})
	}
</script>