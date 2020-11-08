<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 맵 보여야 함, 리뷰(코멘트) 작성 가능해야 함 -->
<!-- 코멘트에 별점 -->
<c:if test="${loginUser.i_user == shopDetail.i_user }">
	<button onclick="location.href='/shop/regMod?i_shop=${shopDetail.i_shop}'">수정</button>
	<button onclick="location.href='/shop/delShop?i_shop=${shopDetail.i_shop}'">삭제</button>
</c:if>
<h1>샵 사진~~</h1>
<c:forEach items="${shopPicList}" var="item">
	<div id="img${item.i_pic }">
		<c:if test="${loginUser.i_user == shopDetail.i_user }">
			<button style="background:pink" onclick="ajaxDelShopPic(${item.i_pic})">왼쪾사진삭제슝슝</button>
		</c:if>
		<span>${item.shop_pic }</span>
	</div>
</c:forEach>
<hr>
<h1>가게 정보</h1>
<div>가게이름 : ${shopDetail.shop}</div>
<hr>
<h1>코멘트 출력</h1>
<c:forEach items="${commentList}" var="item">
	<div>코멘트 쓴 사람 : ${item.nm}</div>
	<div>코멘트 내용 : ${item.comment_ctnt}</div>
</c:forEach>
<hr>
<form id="commentFrm" action="/comment/ajaxRegModComment" onsubmit="return chkComment()">
	<textarea name="comment_ctnt"></textarea>
	<input type="hidden" name="i_shop" value="${shopDetail.i_shop }">
	<input type="hidden" name="i_user" value="${loginUser.i_user }">
	<input type="hidden" name="i_comment" value="0">
	<input type="submit" value="등록">
</form>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function chkComment() {
		console.log('무적권 false');
		return false;
	}

	function ajaxDelShopPic(i_pic) {
		if(confirm('삭제하시겠습니까?')) {
			const param = {
					params: {
						'i_shop' : ${shopDetail.i_shop},
						'i_pic' : i_pic
					}
			};
			
			axios.get('/shop/ajaxDelShopPic', param)
				.then(function(res) {
					console.log(res);	
					const result = res.data;
					
					if(result == 1) {
						alert('삭제되었습니다.');
						const element = document.querySelector('#img' + i_pic);
						element.remove();
					} else {
						alert('삭제 실패');
					}
				});
		}
	}
	
	// 아직 안 씀
	function ajaxSelShopPic() {
		const param = {
			params : {
				'i_shop' : ${shopDetail.i_shop}
			}	
		};
		
		axios.get('/shop/ajaxSelShopPic', param)
			.then(function(res) {
				const result = res.data;
				console.log(result);
			});
	}
	
	

</script>